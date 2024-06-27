extends Control

@onready var PLACE = null
@onready var SFX = $SFX
@onready var itemContainer = $Item_container
@onready var itemDescriptionContainer = $Item_description_container

var is_hidden = true

func _ready():
	GlobalItemsLevel.item_updated.connect(_on_item_updated)
	GlobalItemsLevel.item_upgraded.connect(_on_item_upgraded)
	GlobalActionBar.current_area_changed.connect(_on_current_area_changed)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_item_updated():
	$Item_description_container._refresh()
	$Item_container._refresh()

func _on_item_upgraded(itemName):
	$Item_description_container._refresh()
	$Item_container._refresh()

func init_items():
	itemContainer._refresh()
	$Item_container._refresh()

func _on_current_area_changed():
	init_items()


func _on_hide_button_pressed():
	# Play click SFX
	SFX.set_volume_db(GameAudio.get_volume_sfx())
	GameAudio.play(SFX, GameAudio.SFX_MainMenu_Click)
	
	is_hidden = !is_hidden
	
	var tween = get_tree().create_tween()
	if is_hidden:
		tween.tween_property(self, "position", Vector2(960, 1050), 0.5)
	else:
		tween.tween_property(self, "position", Vector2(960, 521), 0.5)


func _on_hide_button_mouse_entered():
	# Play hover SFX
	SFX.set_volume_db(GameAudio.get_volume_sfx())
	GameAudio.play(SFX, GameAudio.SFX_MainMenu_Hover)
