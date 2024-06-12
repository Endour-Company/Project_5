extends Node2D

var SCENE_LAMPU = preload("res://Game/Area_pemukiman/Lib/item_ct_lampujalan/item_lampu.tscn")

var POINTS_LAMPU = [
	{
		"id" : "lampu1",
		"points" : Vector2(320, 116),
		"is_filled" : false
	},
	{
		"id" : "lampu2",
		"points" : Vector2(487, 388),
		"is_filled" : false
	},
	{
		"id" : "lampu3",
		"points" : Vector2(854, 388),
		"is_filled" : false
	},
	{
		"id" : "lampu4",
		"points" : Vector2(1213, 388),
		"is_filled" : false
	},
	{
		"id" : "lampu5",
		"points" : Vector2(1513, 388),
		"is_filled" : false
	},
]

func _ready():
	GlobalItemsLevel.item_upgraded.connect(_on_item_upgraded)
	
	
func _on_item_upgraded(itemName):
	if itemName == "Lampu Jalan Pemukiman":
		place_lampu()
		
		
func place_lampu():
	for lampu in POINTS_LAMPU:
		if lampu["is_filled"] == false:
			var sceneLampu = SCENE_LAMPU.instantiate()
			sceneLampu.set_position(lampu["points"])
			add_child(sceneLampu)
			lampu["is_filled"] = true
			break
