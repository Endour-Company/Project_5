extends Node2D

@onready var SFX = $SFX
var DATA_OF_POHON : Dictionary = {}

var NAME_OF_POHON : String = ""
var ID_OF_POINT : String = ""

enum STATES_POHON {
	GROWTH,
	READY_TO_HARVEST
}

var STATE_POHON = STATES_POHON.GROWTH

@export var GROWTH_DURATION = 150
var HALF_GROWTH_DURATION = GROWTH_DURATION / 2.0
var TIME_ELAPSED = 0.0


signal pohon_cutted(id : String)

func _ready():
	init_pohon_data()
	
	set_pohon_texture("low")
	STATE_POHON = STATES_POHON.GROWTH
	$TextureProgressBar.max_value = GROWTH_DURATION
	$TextureProgressBar.value = 0
	
	state_growth()
	
	# Play nanem sfx
	if GlobalActionBar.CURRENT_AREA == GlobalActionBar.AREAS.HUTAN:
		SFX.set_volume_db(GameAudio.get_volume_sfx())
		GameAudio.play(SFX, GameAudio.SFX_Plant)


func init_pohon_data():
	var dataOfPohonInAreaHutan = Utils.find_item_in_array_with_key(GlobalItemsLevel.ITEMS_PER_AREA, "area", GlobalActionBar.AREAS.HUTAN)
	var dataOfPohons =  dataOfPohonInAreaHutan["items"]
	var dataOfPohon = Utils.find_item_in_array_with_key(dataOfPohons, "name", NAME_OF_POHON)
	
	DATA_OF_POHON = dataOfPohon


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if STATE_POHON == STATES_POHON.GROWTH:
		TIME_ELAPSED += delta
		$TextureProgressBar.value = TIME_ELAPSED
		if TIME_ELAPSED >= HALF_GROWTH_DURATION and TIME_ELAPSED < GROWTH_DURATION:
			set_pohon_texture("high")
		elif TIME_ELAPSED >= GROWTH_DURATION:
			state_ready_to_harvest()

func state_growth() -> void:
	STATE_POHON = STATES_POHON.GROWTH
	TIME_ELAPSED = 0.0
	set_pohon_texture("low")
	

func state_ready_to_harvest() -> void:
	STATE_POHON = STATES_POHON.READY_TO_HARVEST
	$TextureProgressBar.value = GROWTH_DURATION
	
	
	

func _on_texture_progress_bar_value_changed(value):
	pass # Replace with function body.

func set_pohon_texture(size: String) -> void:
	for image in DATA_OF_POHON.images:
		if image.size == size:
			var img = load(image.img)
			var sprite : Sprite2D = $Sprite2D
			sprite.set_texture(img)
			break



func cut_pohon():
	if (STATE_POHON == STATES_POHON.READY_TO_HARVEST):
		# Play nebang sfx
		if GlobalActionBar.CURRENT_AREA == GlobalActionBar.AREAS.HUTAN:
			SFX.set_volume_db(GameAudio.get_volume_sfx())
			GameAudio.play(SFX, GameAudio.SFX_Cut)
		
		set_pohon_texture("cut")
		
	await get_tree().create_timer(5).timeout
	money_income()
	queue_free()
	GlobalItemsLevel.change_item_count(NAME_OF_POHON, -1)
	emit_signal("pohon_cutted", ID_OF_POINT)
	

func money_income() :
	var income : int = DATA_OF_POHON["sell_price"]
	Variables.set_money("plus",income * Variables.VAR_PENDAPATAN)
