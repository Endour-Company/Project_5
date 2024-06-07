extends Control


# Called when the node enters the scene tree for the first time.

@onready var PLACE = null

@onready var itemContainer = $Item_container
@onready var itemDescriptionContainer = $Item_description_container


func _ready():
	GlobalItemsLevel.item_upgraded.connect(_on_item_upgraded)
	GlobalActionBar.current_area_changed.connect(_on_current_area_changed)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_item_upgraded():
	$Item_description_container._refresh()
	$Item_container._refresh()

func init_items():
	var items = GlobalItemsLevel.ITEMS_JSON
	itemContainer.init_items(items)
	itemDescriptionContainer.init_items(items)

func _on_current_area_changed():
	init_items()

