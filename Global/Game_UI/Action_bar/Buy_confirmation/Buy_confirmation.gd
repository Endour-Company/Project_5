extends Control


# Called when the node enters the scene tree for the first time.
var ITEM_NAME : String = GlobalActionBar.CURRENT_SELECTED_ITEM
var ITEM_UPGRADE_PRICE : int = 0


func _ready():
	$Box/Item_price_container/Item_name.set_text(ITEM_NAME)
	set_item_price()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_cancel_button_pressed():
	queue_free()


func _on_buy_button_pressed():
	var isItemAllowToUpgrade = false
	
	# Check Money
	if Variables.MONEY - ITEM_UPGRADE_PRICE >= 0 :
		isItemAllowToUpgrade = true
	
	
	if isItemAllowToUpgrade :
		GlobalItemsLevel.upgrade_item(GlobalActionBar.CURRENT_SELECTED_ITEM)
		Variables.set_money("min", ITEM_UPGRADE_PRICE)
		queue_free()
	else :
		$Box/Label_not_enough_money.set_visible(true)
		await get_tree().create_timer(5).timeout
		$Box/Label_not_enough_money.set_visible(false)
				

func set_item_price():
	var itemCurrentLevelData = Utils.find_item_in_array_with_key(GlobalItemsLevel.ITEM_LEVEL, "name", ITEM_NAME)
	var itemCurrentLevel = itemCurrentLevelData["level"]
	var itemsDataInCurrentAreaPackaged  = Utils.find_item_in_array_with_key(GlobalItemsLevel.ITEMS_PER_AREA, "area", GlobalActionBar.CURRENT_AREA)
	
	var itemsDataInCurrentArea = itemsDataInCurrentAreaPackaged["items"]
	var itemDataInCurrentArea = Utils.find_item_in_array_with_key(itemsDataInCurrentArea, "name", ITEM_NAME)
	
	var itemLevelsDataInCurrentArea = itemDataInCurrentArea["levels"]
	var itemLevelDataInCurrentArea = Utils.find_item_in_array_with_key(itemLevelsDataInCurrentArea, "level", itemCurrentLevel)
	
	var itemUpgradePrice = itemLevelDataInCurrentArea["upgrade_price"]
	
	ITEM_UPGRADE_PRICE = itemUpgradePrice
	
	var formattedItemUpgradePrice = Utils.format_rupiah(ITEM_UPGRADE_PRICE)
	$Box/Item_price_container/Item_price.set_text(formattedItemUpgradePrice)
	
	
