extends Node



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
		GlobalActionBar.AREAS.HUTAN: $Area_Hutan
	}
	
	for area in areas:
		areas[area].visible = (area == GlobalActionBar.CURRENT_AREA)

func _on_current_area_changed():
	init_area()
