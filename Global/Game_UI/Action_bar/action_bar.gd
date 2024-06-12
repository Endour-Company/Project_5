extends Control


# Called when the node enters the scene tree for the first time.

@onready var PLACE = null

@onready var itemContainer = $Item_container
@onready var itemDescriptionContainer = $Item_description_container


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
	$Item_container._refresh()

func _on_current_area_changed():
	init_items()

