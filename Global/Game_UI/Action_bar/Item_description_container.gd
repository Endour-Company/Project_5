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
	
	# Cek apakah item upgradable
	var itemLevels = currentItem["levels"]
	var currentLevel = Utils.find_item_in_array_with_key(GlobalItemsLevel.ITEM_LEVEL, "name", itemName)
	if(currentItem["type"] == "upgradable"):
		$HBoxContainer/Item_levels.init_level(currentLevel["level"],itemLevels.size())
		$HBoxContainer/Item_levels.set_visible(true)
		$HBoxContainer/Item_levels_none.set_visible(false)
		$HBoxContainer/Item_count.set_visible(false)
	elif(currentItem["type"] == "countable"):
		$HBoxContainer/Item_levels.set_visible(false)
		$HBoxContainer/Item_levels_none.set_visible(true)
		$HBoxContainer/Item_count.set_visible(true)
		
		# Set Item count
		$HBoxContainer/Item_count/Label.set_text("Punya : " + str(currentLevel["count"]))
	
	# Set Item Buy Button
	
	var isAllowToBuy : bool = false
	
	if(currentItem["type"] == "upgradable"):
		var isItemMaxLevel : bool = currentLevel["level"] == itemLevels.size()
		isAllowToBuy = !isItemMaxLevel
	elif (currentItem["type"] == "countable"):
		var isItemMaxOwned : bool = currentItem["max_owned"] <= currentLevel["count"]
		isAllowToBuy = !isItemMaxOwned
		print(currentItem["max_owned"])
	
	if (isAllowToBuy) : 
		$HBoxContainer2/Buy_button.set_button_icon(buyButtonNormal)
		$HBoxContainer2/Buy_button.set_disabled(false)
	else :
		$HBoxContainer2/Buy_button.set_button_icon(buyButtonMax)
		$HBoxContainer2/Buy_button.set_disabled(true)
	
	
func init_items(newItems):
	items = newItems

