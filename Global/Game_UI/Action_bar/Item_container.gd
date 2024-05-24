extends GridContainer


@onready var itemPanelFill = preload("res://Global/Game_UI/Action_bar/Item_panel/item_panel_fill.tscn")
@onready var itemPanelEmpty = preload("res://Global/Game_UI/Action_bar/Item_panel/item_panel_empty.tscn")


func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func init_items(items):
	var itemRemaining = 7
	for item in items:
		# cek level dari variabel global
		var itemCurrent = find_item_with_key(GlobalItemsLevel.ITEM_LEVEL, "name",item["name"])
		var itemCurrentLevel = itemCurrent["level"]
			
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
