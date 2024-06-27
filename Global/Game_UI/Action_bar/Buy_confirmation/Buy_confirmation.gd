extends Control

signal buy_signal
signal close_signal

# Called when the node enters the scene tree for the first time.
var ITEM_NAME : String = GlobalActionBar.CURRENT_SELECTED_ITEM
var ITEM_UPGRADE_PRICE : int = 0
@onready var SFX = $SFX

func _ready():
	$Box/Item_price_container/Item_name.set_text(ITEM_NAME)
	set_item_price()
	
	SFX.set_volume_db(GameAudio.get_volume_sfx())

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_cancel_button_pressed():
	close_signal.emit()
	
	queue_free()


func _on_buy_button_pressed():
	var isItemAllowToUpgrade = false
	
	# Check Money
	if Variables.MONEY - ITEM_UPGRADE_PRICE >= 0 :
		isItemAllowToUpgrade = true
	
	
	if isItemAllowToUpgrade :
		buy_signal.emit()
	
		GlobalItemsLevel.upgrade_item(GlobalActionBar.CURRENT_SELECTED_ITEM)
		Variables.set_money("min", ITEM_UPGRADE_PRICE)
		queue_free()
	else :
		# Play click sfx
		GameAudio.play(SFX, GameAudio.SFX_MainMenu_Close)
		await get_tree().create_timer(0.2).timeout
		
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
	
	


func _on_buy_button_mouse_entered():
	GameAudio.play(SFX, GameAudio.SFX_Gameplay_Hover)


func _on_cancel_button_mouse_entered():
	GameAudio.play(SFX, GameAudio.SFX_Gameplay_Hover)
