extends Node2D

var SCENE_ITEM_POHON = preload("res://Game/Area_hutan/Lib/item_pohon/item_pohon.tscn")

var DATA_POHONS : Array = []

var POINT_POHONS : Array = [
	{
		"part_name" : "Mahoni",
		"node" : $Part_mahonis,
		"points" : [
		{
			"point": Vector2(247, 302),
			"is_filled": false
		},
		{
			"point": Vector2(564, 244),
			"is_filled": false
		},
		{
			"point": Vector2(876, 249),
			"is_filled": false
		}
		]
	},
	{
		"part_name" : "Pinus",
		"node" : $Part_pinuses,
		"points" : [
			{
				"point": Vector2(49, 631),
				"is_filled": false
			},
			{
				"point": Vector2(363, 595),
				"is_filled": false
			},
			{
				"point": Vector2(682, 578),
				"is_filled": false
			},
			{
				"point": Vector2(991, 555),
				"is_filled": false
			}
		]
	},
	{
		"part_name" : "Jati",
		"node" : $Part_jatis,
		"points" : [
			{
				"point": Vector2(112, 888),
				"is_filled": false
			},
			{
				"point": Vector2(471, 893),
				"is_filled": false
			},
			{
				"point": Vector2(816, 873),
				"is_filled": false
			},
			{
				"point": Vector2(1157, 861),
				"is_filled": false
			}
		]
	},
]


func _ready():
	GlobalItemsLevel.item_upgraded.connect(_on_pohon_planted)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func init_data_pohons(dataPohons : Array) -> void:
	DATA_POHONS = dataPohons

func _on_pohon_planted(nameOfItem):
	var itemLevel = GlobalItemsLevel.ITEM_LEVEL
	
	# Confirm that pohon is upgraded
	var partsOfPohon = []
	for pointPohonData in POINT_POHONS :
		partsOfPohon.append(pointPohonData["part_name"])
	
	if nameOfItem in  partsOfPohon :
		var nameOfPohon = nameOfItem
		
		var partOfPohon = Utils.find_item_in_array_with_key(POINT_POHONS, "part_name", nameOfPohon)
		var pointsOfPohon = partOfPohon["points"]
		
		var isPlanted = false
		for pointOfPohon in pointsOfPohon :
			if isPlanted == false and pointOfPohon["is_filled"] == false:
				var pointToBePlanted = pointOfPohon["point"]
				var sceneItemPohon = SCENE_ITEM_POHON.instantiate()
				sceneItemPohon.set_position(pointToBePlanted)
				
				var nodes = {
					"Mahoni" : $Part_mahonis,
					"Jati" : $Part_jatis,
					"Pinus" : $Part_pinuses
				}
				
				nodes[nameOfPohon].add_child(sceneItemPohon)
				
				isPlanted = true
				# Set this point to filled = true
				pointOfPohon["is_filled"] = true
				
