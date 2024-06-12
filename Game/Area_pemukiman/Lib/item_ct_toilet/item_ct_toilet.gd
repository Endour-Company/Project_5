extends Node2D

var SCENE_TOILET = preload("res://Game/Area_pemukiman/Lib/item_ct_toilet/item_toilet.tscn")

var COUNT_TOILET = 0

var POINTS_TOILET = [
	{
		"id" : "toilet1",
		"points" : Vector2(1607, 491),
		"is_filled" : false
	},
	{
		"id" : "toilet2",
		"points" : Vector2(1674, 491),
		"is_filled" : false
	},
	{
		"id" : "toilet3",
		"points" : Vector2(1742, 491),
		"is_filled" : false
	},
	{
		"id" : "toilet4",
		"points" : Vector2(1630, 352),
		"is_filled" : false
	},
	{
		"id" : "toilet5",
		"points" : Vector2(1697, 352),
		"is_filled" : false
	},
	{
		"id" : "toilet6",
		"points" : Vector2(1765, 352),
		"is_filled" : false
	},
]

func _ready():
	GlobalItemsLevel.item_upgraded.connect(_on_item_upgraded)
	

func _on_item_upgraded(itemName):
	place_toilet()
	

func place_toilet():
	for toilet in POINTS_TOILET:
		if (toilet["is_filled"] == false):
			var sceneToilet = SCENE_TOILET.instantiate()
			sceneToilet.set_position(toilet["points"])
			add_child(sceneToilet)
			toilet["is_filled"] = true
			break
