extends Node2D


# Called when the node enters the scene tree for the first time.

var SCENE_LAMPU_SAWAH = preload("res://Game/Ricefield/Lib/Subarea_lampu_sawah/item_lampu_sawah.tscn")

var COUNT_LAMPU_SAWAH = 0


var POINTS_LAMPU_SAWAH = [
	{
		"id" : "lampuSawah1",
		"points" : Vector2(808,726) ,
		"is_filled" : false
	},
	{
		"id" : "lampuSawah2",
		"points" : Vector2(58,69) ,
		"is_filled" : false
	},
	{
		"id" : "lampuSawah3",
		"points" : Vector2(1560,314) ,
		"is_filled" : false
	},
]
func _ready():
	GlobalItemsLevel.item_upgraded.connect(_on_item_upgraded)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_item_upgraded(itemName):
	place_lampu_sawah()

func place_lampu_sawah():
	for pointLampuSawah in POINTS_LAMPU_SAWAH :
		if (pointLampuSawah["is_filled"] == false) :
			var lampuSawah = SCENE_LAMPU_SAWAH.instantiate()
			lampuSawah.set_position(pointLampuSawah["points"])
			add_child(lampuSawah)
			pointLampuSawah["is_filled"] = true
			break
