extends Node2D

var SCENE_TOWER = preload("res://Game/Area_pemukiman/Lib/item_ct_tower/item_tower.tscn")

var POINTS_TOWER = [
	{
		"id" : "tower1",
		"points" : Vector2(540, 270),
		"is_filled" : false
	},
	{
		"id" : "tower2",
		"points" : Vector2(1796, 270),
		"is_filled" : false
	},
]

func _ready():
	GlobalItemsLevel.item_upgraded.connect(_on_item_upgraded)
	
	
func _on_item_upgraded(itemName):
	if itemName == "Tower Internet":
		place_tower()
	
	
func place_tower():
	for tower in POINTS_TOWER:
		if (tower["is_filled"] == false) :
			var sceneTower : AnimatedSprite2D = SCENE_TOWER.instantiate()
			sceneTower.set_position(tower["points"])
			sceneTower.play()
			add_child(sceneTower)
			tower["is_filled"] = true
			break
