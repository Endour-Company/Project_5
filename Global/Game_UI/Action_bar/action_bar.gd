extends Control


# Called when the node enters the scene tree for the first time.

@onready var PLACE = null

@onready var itemContainer = $Item_container
var itemsPath = "res://Data/Items_ricefields.json"


func load_json_file(filePath : String):
	if FileAccess.file_exists(itemsPath):
		var dataFile = FileAccess.open(itemsPath, FileAccess.READ)
		var parsedResult = JSON.parse_string(dataFile.get_as_text())
		return parsedResult
	else:
		return null

func _ready():
	var items = load_json_file(itemsPath)
	itemContainer.init_items(items)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
