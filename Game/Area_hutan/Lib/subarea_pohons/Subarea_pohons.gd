extends Node2D


var DATA_POHONS : Array = []

var POINT_POHONS : Array = [
	{
		"part_name" : "mahonis",
		"points" : [
			{
				"point" : Vector2(272,302),
				"is_filled" : false
			},
			{
				"point" : Vector2(272,302),
				"is_filled" : false
			},
			{
				"point" : Vector2(272,302),
				"is_filled" : false
			},
		]
	},
	{
		"part_name" : "cendanas",
		"points" : [
			{
				"point" : Vector2(272,302),
				"is_filled" : false
			},
			{
				"point" : Vector2(272,302),
				"is_filled" : false
			},
			{
				"point" : Vector2(272,302),
				"is_filled" : false
			},
		]
	},
	{
		"part_name" : "jatis",
		"points" : [
			{
				"point" : Vector2(272,302),
				"is_filled" : false
			},
			{
				"point" : Vector2(272,302),
				"is_filled" : false
			},
			{
				"point" : Vector2(272,302),
				"is_filled" : false
			},
		]
	},
]


func _ready():
	GlobalItemsLevel.item_upgraded.connect(_on_item_upgraded)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func init_data_pohons(dataPohons : Array) -> void:
	DATA_POHONS = dataPohons

func _on_item_upgraded():
	var itemLevel = GlobalItemsLevel.ITEM_LEVEL
	
	# Check changes 'pohon' in itemLevel
	
	# Mahoni
	var mahoniCount = Utils.find_item_in_array_with_key(itemLevel, "name", "Mahoni")
	print(mahoniCount)
