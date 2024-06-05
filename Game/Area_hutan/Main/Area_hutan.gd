extends Node2D

var DATA_POHONS_PATH = "res://Data/Items_hutan.json"
var DATA_POHONS : Array = [] 
# Called when the node enters the scene tree for the first time.
func _ready():
	load_data_pohons_from_json()
	print(DATA_POHONS)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func load_data_pohons_from_json() -> void:
	var dataPohons = Utils.parse_json_file_by_filepath(DATA_POHONS_PATH)
	DATA_POHONS = dataPohons
	$Subarea_pohons.init_data_pohons(DATA_POHONS)
	
