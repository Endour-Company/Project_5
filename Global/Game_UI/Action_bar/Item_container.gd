extends GridContainer


@onready var itemPanelFill = preload("res://Global/Game_UI/Action_bar/Item_panel/item_panel_fill.tscn")
@onready var itemPanelEmpty = preload("res://Global/Game_UI/Action_bar/Item_panel/item_panel_empty.tscn")


func _ready():
	init_items_to_panel()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func init_items(items):
	pass


func init_items_to_panel():
	var currentArea = GlobalActionBar.CURRENT_AREA
	var itemsInCurrentAreaData = Utils.find_item_in_array_with_key(GlobalItemsLevel.ITEMS_PER_AREA, "area", currentArea)
	var itemsInCurrentArea = itemsInCurrentAreaData["items"]
	
	
	var itemRemaining = 7
	for item in itemsInCurrentArea:
		# cek level dari variabel global
		var itemCurrentLevelData = find_item_with_key(GlobalItemsLevel.ITEM_LEVEL, "name",item["name"])
		var itemCurrentLevel = itemCurrentLevelData["level"]
			
		var myItem = find_item_with_key(item["levels"], "level",itemCurrentLevel)
		
		var panelFill = itemPanelFill.instantiate()
		add_child(panelFill)
		
		if(myItem != null):
			panelFill.init_item_panel(myItem["img"], myItem["upgrade_price"],item["name"])
		
		itemRemaining-=1
	
	if(itemRemaining != 0): 
		for i in range(0,itemRemaining):
			var panelEmpty = itemPanelEmpty.instantiate()
			add_child(panelEmpty)


func find_item_with_key(arr : Array,key:String,value):
	for item in arr:
		if(item[key] == value):
			return item
	return null

func _refresh():
	for child in get_children():
		child.queue_free()
	
	init_items_to_panel()
