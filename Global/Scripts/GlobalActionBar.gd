extends Node


# Called when the node enters the scene tree for the first time.

var CURRENT_SELECTED_ITEM = null

enum AREAS {
	SAWAH,
	HUTAN,
	PEMUKIMAN,
	PUSATDESA
}

@export var CURRENT_AREA = AREAS.SAWAH

signal current_selected_item_changed(selected_item_name : String)

signal current_area_changed()

func _ready():
	current_area_changed.connect(_on_current_area_changed)
	_on_current_area_changed()
	print(CURRENT_SELECTED_ITEM)
	
	
func _process(delta):
	pass

func _on_current_area_changed():
	# SET FIRST ITEM IN AREA
	var firstItemDataInCurrentArea = (Utils.find_item_in_array_with_key(GlobalItemsLevel.ITEMS_PER_AREA, "area", CURRENT_AREA))["items"][0]
	var firstItemNameInCurrentArea = firstItemDataInCurrentArea["name"]
	set_selected_item(firstItemNameInCurrentArea)
	
func set_selected_item(selected_item_name : String):
	CURRENT_SELECTED_ITEM = selected_item_name
	emit_signal("current_selected_item_changed", selected_item_name)

func set_current_area(AREA):
	CURRENT_AREA = AREA
	emit_signal("current_area_changed")
