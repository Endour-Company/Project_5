extends Node2D

var DATA_OF_POHON : Dictionary = {}

var NAME_OF_POHON : String = ""

enum STATES_POHON {
	GROWTH,
	READY_TO_HARVEST
}

var STATE_POHON = STATES_POHON.GROWTH

@export var GROWTH_DURATION = 20.0
var HALF_GROWTH_DURATION = GROWTH_DURATION / 2.0
var TIME_ELAPSED = 0.0


func _ready():
	init_pohon_data()
	
	set_pohon_texture("low")
	STATE_POHON = STATES_POHON.GROWTH
	$TextureProgressBar.max_value = GROWTH_DURATION
	$TextureProgressBar.value = 0
	
	state_growth()


func init_pohon_data():
	var dataOfPohonInAreaHutan = Utils.find_item_in_array_with_key(GlobalItemsLevel.ITEMS_PER_AREA, "area", GlobalActionBar.AREAS.HUTAN)
	var dataOfPohons =  dataOfPohonInAreaHutan["items"]
	var dataOfPohon = Utils.find_item_in_array_with_key(dataOfPohons, "name", NAME_OF_POHON)
	
	DATA_OF_POHON = dataOfPohon


func init_pohon_visual():
	print(DATA_OF_POHON)

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
	print("ready_to_harvest")
	

func _on_texture_progress_bar_value_changed(value):
	pass # Replace with function body.

func set_pohon_texture(size: String) -> void:
	for image in DATA_OF_POHON.images:
		if image.size == size:
			var img = load(image.img)
			$Sprite2D.set_texture(img)
			break
