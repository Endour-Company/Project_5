extends Node


var ITEMS_JSON = []

var ITEM_LEVEL = [
	{
		"name" : "Pembajak",
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
	}
]


signal item_upgraded


func _ready():
	var itemsJson = Utils.parse_json_file_by_filepath("res://Data/Items_ricefields.json")
	ITEMS_JSON = itemsJson
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func upgrade_item(itemName):
	var item = Utils.find_item_in_array_with_key(ITEMS_JSON, "name",itemName)
	
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
		emit_signal("item_upgraded")

		
