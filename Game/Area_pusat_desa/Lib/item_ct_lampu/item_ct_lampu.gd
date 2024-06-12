extends Node2D

var SCENE_LAMPU = preload("res://Game/Area_pusat_desa/Lib/item_ct_lampu/item_lampu.tscn")

var POINTS_LAMPU = [
	{
		"id" : "lampu1",
		"points" : Vector2(202, 128),
		"is_filled" : false
	},
	{
		"id" : "lampu1",
		"points" : Vector2(1565, 145),
		"is_filled" : false
	},
	{
		"id" : "lampu1",
		"points" : Vector2(167, 712),
		"is_filled" : false
	},
	{
		"id" : "lampu1",
		"points" : Vector2(1531, 705),
		"is_filled" : false
	},
	{
		"id" : "lampu1",
		"points" : Vector2(928, -6),
		"is_filled" : false
	},
	{
		"id" : "lampu1",
		"points" : Vector2(794, 867),
		"is_filled" : false
	},
]


func _ready():
	GlobalItemsLevel.item_upgraded.connect(_on_item_upgraded)
	
	
func _on_item_upgraded(itemName):
	if itemName == "Lampu Jalan Pusat Desa":
		place_lampu()
		
		
func place_lampu():
	for lampu in POINTS_LAMPU:
		if lampu["is_filled"] == false:
			var sceneLampu = SCENE_LAMPU.instantiate()
			sceneLampu.set_position(lampu["points"])
			add_child(sceneLampu)
			lampu["is_filled"] = true
			break
