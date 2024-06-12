extends Node

var sceneMap : Control

# Called when the node enters the scene tree for the first time.
func _ready():
	GlobalActionBar.current_area_changed.connect(_on_current_area_changed)
	init_area()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func init_area():
	var areas = {
		GlobalActionBar.AREAS.SAWAH: $Ricefield_area,
		GlobalActionBar.AREAS.HUTAN: $Area_Hutan,
		GlobalActionBar.AREAS.PEMUKIMAN: $AreaPemukiman,
		GlobalActionBar.AREAS.PUSATDESA: $AreaPusat
	}
	
	for area in areas:
		areas[area].visible = (area == GlobalActionBar.CURRENT_AREA)

func _on_current_area_changed():
	init_area()


func _on_map_texture_button_pressed():
	sceneMap = preload("res://Global/Game_UI/Map/Main/Map.tscn").instantiate()
	sceneMap.close_signal.connect(_on_map_close)
	sceneMap.area_hutan.connect(_on_area_hutan)
	sceneMap.area_sawah.connect(_on_area_sawah)
	sceneMap.area_pemukiman.connect(_on_area_pemukiman)
	sceneMap.area_pusatdesa.connect(_on_area_pusatdesa)
	add_child(sceneMap)


func _on_map_close():
	close_map()
	
	
func _on_area_hutan():
	GlobalActionBar.set_current_area(GlobalActionBar.AREAS.HUTAN)
	close_map()
	
func _on_area_sawah():
	GlobalActionBar.set_current_area(GlobalActionBar.AREAS.SAWAH)
	close_map()
	
func _on_area_pemukiman():
	GlobalActionBar.set_current_area(GlobalActionBar.AREAS.PEMUKIMAN)
	close_map()
	
func _on_area_pusatdesa():
	GlobalActionBar.set_current_area(GlobalActionBar.AREAS.PUSATDESA)
	close_map()
	
	
func close_map():
	sceneMap.queue_free()
