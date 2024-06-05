extends Node2D

var DATA_POHON : Dictionary = {
	"name" : "Mahoni",
	"point" : Vector2(Vector2.ZERO),
	"images" : [
		
	],
	"growth_speed" : 0.5
}


enum STATES_POHON {
	GROWTH,
	READY_TO_HARVEST
}

var STATE_POHON = STATES_POHON.GROWTH

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	match STATE_POHON :
		STATES_POHON.GROWTH :
			pass
		STATES_POHON.READY_TO_HARVEST :
			pass


func init_pohon(dataPohon):
	DATA_POHON = dataPohon

func state_growth() -> void:
	pass

func state_ready_to_harvest() -> void:
	pass
	

func _on_texture_progress_bar_value_changed(value):
	pass # Replace with function body.
