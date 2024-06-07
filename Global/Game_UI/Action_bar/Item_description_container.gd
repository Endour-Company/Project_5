extends VBoxContainer


# Called when the node enters the scene tree for the first time.

var buyButtonNormal = load("res://Global/Game_UI/Action_bar/Assets/Buy_ver2.png")
var buyButtonMax = load("res://Global/Game_UI/Action_bar/Assets/Buy_max.png")

var CURRENT_ITEM_NAME = null

func _ready():
	GlobalActionBar.current_selected_item_changed.connect(_on_current_selected_item_changed)

func _process(delta):
	pass


func _on_current_selected_item_changed(current_selected_item_name : String):
	CURRENT_ITEM_NAME = GlobalActionBar.CURRENT_SELECTED_ITEM
	set_description_body()

func set_description_body():
	var currentArea = GlobalActionBar.CURRENT_AREA
	var itemsInCurrentAreaData = Utils.find_item_in_array_with_key(GlobalItemsLevel.ITEMS_PER_AREA, "area",currentArea)
	var itemsInCurrentArea = itemsInCurrentAreaData["items"]
	var currentItem = Utils.find_item_in_array_with_key(itemsInCurrentArea,"name", CURRENT_ITEM_NAME)
	var itemName = currentItem["name"]
	var itemDescription = currentItem["description"]
	$HBoxContainer/Item_name.set_text(itemName)
	$HBoxContainer2/Item_description.set_text(itemDescription)
	
	
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

	
	if (isAllowToBuy) : 
		$HBoxContainer2/Buy_button.set_button_icon(buyButtonNormal)
		$HBoxContainer2/Buy_button.set_disabled(false)
	else :
		$HBoxContainer2/Buy_button.set_button_icon(buyButtonMax)
		$HBoxContainer2/Buy_button.set_disabled(true)
	
func set_description_empty():
	pass


func _on_buy_button_button_up():
	GlobalItemsLevel.upgrade_item(CURRENT_ITEM_NAME)

func _refresh():
	set_description_body()
