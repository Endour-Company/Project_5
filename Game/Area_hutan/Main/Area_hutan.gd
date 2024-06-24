extends Node2D

var DATA_POHONS_PATH = "res://Data/Items_hutan.json"
var DATA_POHONS : Array = [] 
# Called when the node enters the scene tree for the first time.
func _ready():
	load_data_pohons_from_json()



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	watch_count_pohon()

func load_data_pohons_from_json() -> void:
	var dataPohons = Utils.parse_json_file_by_filepath(DATA_POHONS_PATH)
	DATA_POHONS = dataPohons
	$Subarea_pohons.init_data_pohons(DATA_POHONS)
	

func watch_count_pohon() -> void :
	var count = 0
	var countMahonis = $Subarea_pohons/Part_mahonis.get_child_count()
	var countCendanas = $Subarea_pohons/Part_cendanas.get_child_count()
	var countJatis = $Subarea_pohons/Part_jatis.get_child_count()
	
	count = countMahonis + countCendanas + countJatis
	Variables.COUNT_POHON = count
