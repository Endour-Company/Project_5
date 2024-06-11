extends Node2D

var SCENE_ITEM_POHON = preload("res://Game/Area_hutan/Lib/item_pohon/item_pohon.tscn")

var DATA_POHONS : Array = []

var POINT_POHONS : Array = [
	{
		"part_name" : "Mahoni",
		"node" : $Part_mahonis,
		"offset" : Vector2(60, -640),
		"points" : [
		{
			"id" : "mahoni1",
			"point": Vector2(247, 302),
			"is_filled": false
		},
		{
			"id" : "mahoni2",
			"point": Vector2(564, 244),
			"is_filled": false
		},
		{
			"id" : "mahoni3",
			"point": Vector2(876, 249),
			"is_filled": false
		}
		]
	},
	{
		"part_name" : "Cendana",
		"offset" : Vector2(120,-670),
		"points" : [
			{
				"id" : "cendana1",
				"point": Vector2(49, 631),
				"is_filled": false
			},
			{
				"id" : "cendana2",
				"point": Vector2(363, 595),
				"is_filled": false
			},
			{
				"id" : "cendana3",
				"point": Vector2(682, 578),
				"is_filled": false
			},
			{
				"id" : "cendana4",
				"point": Vector2(991, 555),
				"is_filled": false
			}
		]
	},
	{
		"part_name" : "Jati",
		"node" : $Part_jatis,
		"offset" : Vector2(60,-640),
		"points" : [
			{
				"id" : "jati1",
				"point": Vector2(112, 888),
				"is_filled": false
			},
			{
				"id" : "jati2",
				"point": Vector2(471, 893),
				"is_filled": false
			},
			{
				"id" : "jati3",
				"point": Vector2(816, 873),
				"is_filled": false
			},
			{
				"id" : "jati4",
				"point": Vector2(1157, 861),
				"is_filled": false
			}
		]
	},
]

var COUNT_MAHONIS  :int = 0
var COUNT_CENDANAS : int = 0
var COUNT_JATIS : int = 0

var SCAN_INTERVAL : float = 5.0

# Timer untuk scanning pohon
var SCAN_TIMER : Timer

func _ready():
	GlobalItemsLevel.item_upgraded.connect(_on_pohon_planted)
	
	SCAN_TIMER = Timer.new()
	SCAN_TIMER.set_wait_time(SCAN_INTERVAL)
	SCAN_TIMER.set_one_shot(false)
	SCAN_TIMER.timeout.connect(_on_scan_timer_timeout)
	add_child(SCAN_TIMER)
	SCAN_TIMER.start()


func _process(delta):
	
	_update_tree_count_and_connect($Part_mahonis, COUNT_MAHONIS)
	_update_tree_count_and_connect($Part_cendanas, COUNT_CENDANAS)
	_update_tree_count_and_connect($Part_jatis, COUNT_JATIS)
	
	# Set scan interval
	var scanInterval = 15 / Variables.LOGGING_VOLUME
	SCAN_INTERVAL = scanInterval

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
				sceneItemPohon.NAME_OF_POHON = nameOfPohon
				sceneItemPohon.ID_OF_POINT = pointOfPohon["id"]
				
				var nodes = {
					"Mahoni" : $Part_mahonis,
					"Jati" : $Part_jatis,
					"Cendana" : $Part_cendanas
				}
				
				nodes[nameOfPohon].add_child(sceneItemPohon)
				
				isPlanted = true
				# Set this point to filled = true
				pointOfPohon["is_filled"] = true
				
func _update_tree_count_and_connect(partNode, countVariable):
	var currentCount = partNode.get_child_count()
	if countVariable != currentCount:
		countVariable = currentCount
		for pohon in partNode.get_children():
			pohon.pohon_cutted.connect(_on_pohon_cutted)
			

func _scan_tree_to_logging(partNode):
	var pohonsNode = partNode.get_children()
	var pohonsNodeCount = partNode.get_child_count()
	var isScanDone = false
	if pohonsNodeCount != 0 :
		for pohonNode in pohonsNode :
			if pohonNode.STATE_POHON == pohonNode.STATES_POHON.READY_TO_HARVEST and isScanDone == false:
				pohonNode.cut_pohon()
				isScanDone = true
			
func _on_scan_timer_timeout():
	_scan_tree_to_logging($Part_mahonis)
	_scan_tree_to_logging($Part_cendanas)
	_scan_tree_to_logging($Part_jatis)

func _on_pohon_cutted(id : String):
	mark_point_as_not_filled(id)

func mark_point_as_not_filled(point_id: String) -> void:
	for part in POINT_POHONS:
		for point in part["points"]:
			if point["id"] == point_id:
				point["is_filled"] = false
				return
