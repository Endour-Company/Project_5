extends Node

var ITEM_LEVEL = [
	{
		"name" : "Alat Pertanian",
		"level" : 1,
		"count" : 1,
		
	},
	{
		"name" : "Jalan",
		"level" : 1,
		"count" : 1,

 	},
	{
		"name" : "Lampu Jalan",
		"level" : 1,
		"count" : 1
	},
	{
		"name" : "Mahoni",
		"level" : 1,
		"count" : 0
	},
	{
		"name" : "Cendana",
		"level" : 1,
		"count" : 0
	},
	{
		"name" : "Jati",
		"level" : 1,
		"count" : 0
	}
]

var ITEMS_PER_AREA : Array = [
	{
		'area' : GlobalActionBar.AREAS.SAWAH,
		'path' : "res://Data/Items_ricefields.json",
		'items' : []
	},
	{
		'area' : GlobalActionBar.AREAS.HUTAN,
		'path' : "res://Data/Items_hutan.json",
		'items' : []
	},
	{
		'area' : GlobalActionBar.AREAS.PEMUKIMAN,
		'path' : "res://Data/Items_pemukiman.json",
		"items" : []
	},
	{
		'area' : GlobalActionBar.AREAS.PUSATDESA,
		'path' : "res://Data/Items_pusat_desa.json",
		"items" : []
	},
]


signal item_upgraded(itemName)


func _ready():
	GlobalActionBar.current_area_changed.connect(_on_current_area_changed)
	init_items_per_area()
	
func init_items_per_area():
	for itemPerArea in ITEMS_PER_AREA :
		var items = Utils.parse_json_file_by_filepath(itemPerArea['path'])
		itemPerArea["items"] = items

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func upgrade_item(itemName):
	var currentArea = GlobalActionBar.CURRENT_AREA
	var itemsInCurrentAreaData = Utils.find_item_in_array_with_key(ITEMS_PER_AREA, "area", currentArea)
	var itemsInCurrentArea = itemsInCurrentAreaData["items"]
	
	var item = Utils.find_item_in_array_with_key(itemsInCurrentArea, "name",itemName)
	

	var itemCurrentStats = Utils.find_item_in_array_with_key(ITEM_LEVEL, "name", itemName)
	var isAllowToUpgrade = false
	
	var itemType = item["type"]

	
	# Check is Item Allow To Upgrade
	match itemType:
		"upgradable":
			if(itemCurrentStats["level"] + 1 <= item["levels"].size()):
				isAllowToUpgrade = true
			else :
				isAllowToUpgrade = false
		"countable" :
			if(itemCurrentStats["count"] + 1 <= item["max_owned"]):
				isAllowToUpgrade = true
			else :
				isAllowToUpgrade = false
	
	if (isAllowToUpgrade):
		match itemType:
			"upgradable" :
				for ITEM in ITEM_LEVEL:
					if ITEM["name"] == itemName:
						ITEM["level"] += 1
						break
			"countable" :
				for ITEM in ITEM_LEVEL:
						if ITEM["name"] == itemName:
							ITEM["count"] += 1
							break
		emit_signal("item_upgraded",itemName)


	
func _on_current_area_changed():
	pass
