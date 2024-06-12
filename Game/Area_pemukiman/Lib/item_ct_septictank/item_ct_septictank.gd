extends Node2D

var SCENE_SEPTICTANK = preload("res://Game/Area_pemukiman/Lib/item_ct_septictank/item_tank.tscn")

var POINTS_SEPTICTANK = [
	{
		"id" : "tank1",
		"points" : Vector2(1415, 826),
		"is_filled" : false
	},
	{
		"id" : "tank2",
		"points" : Vector2(1044, 826),
		"is_filled" : false
	},
	{
		"id" : "tank3",
		"points" : Vector2(668, 826),
		"is_filled" : false
	},
]


func _ready():
	GlobalItemsLevel.item_upgraded.connect(_on_item_upgraded)
	

func _on_item_upgraded(itemName):
	if itemName == "Septic Tank":
		place_tank()
		
		
func place_tank():
	for tank in POINTS_SEPTICTANK:
		if tank["is_filled"] == false:
			var sceneTank = SCENE_SEPTICTANK.instantiate()
			sceneTank.set_position(tank["points"])
			add_child(sceneTank)
			tank["is_filled"] = true
			break
