extends VBoxContainer


# Called when the node enters the scene tree for the first time.

var buyButtonNormal = load("res://Global/Game_UI/Action_bar/Assets/Buy_ver2.png")
var buyButtonMax = load("res://Global/Game_UI/Action_bar/Assets/Buy_max.png")

var CURRENT_ITEM_NAME = null
var items = null
func _ready():
	GlobalActionBar.current_selected_item_changed.connect(_on_current_selected_item_changed)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_current_selected_item_changed(current_selected_item_name : String):
	CURRENT_ITEM_NAME = GlobalActionBar.CURRENT_SELECTED_ITEM
	set_description_body()

func set_description_body():
	var currentItem = Utils.find_item_in_array_with_key(items,"name", CURRENT_ITEM_NAME)
	
	var itemName = currentItem["name"]
	var itemDescription = currentItem["description"]
	$HBoxContainer/Item_name.set_text(itemName)
	$HBoxContainer2/Item_description.set_text(itemDescription)
	
	# Set Item Level Bar
	var itemLevels = currentItem["levels"]
	var currentLevel = Utils.find_item_in_array_with_key(GlobalItemsLevel.ITEM_LEVEL, "name", itemName)
	$HBoxContainer/Item_levels.init_level(currentLevel["level"],itemLevels.size())
	
	# Set Item Buy Button
	var isItemMaxLevel : bool = currentLevel["level"] == itemLevels.size()
	if (isItemMaxLevel) : 
		$HBoxContainer2/Buy_button.set_button_icon(buyButtonMax)
		$HBoxContainer2/Buy_button.set_disabled(true)
	else :
		$HBoxContainer2/Buy_button.set_button_icon(buyButtonNormal)
		$HBoxContainer2/Buy_button.set_disabled(false)
	
func init_items(newItems):
	items = newItems

