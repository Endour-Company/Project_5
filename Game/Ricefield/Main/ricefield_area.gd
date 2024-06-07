extends Node2D


# Called when the node enters the scene tree for the first time.

var VAR_KUALITAS_PADI = 0
var VAR_KUANTITAS_PADI = 0
var VAR_JUMLAH_HAMA = 0
var VAR_TINGKAT_PESTISIDA = 0
var IS_CAR_READY = true


func _ready():
	$Subarea_sawah.sawah_change_state.connect(_on_sawah_change_state)
	$Itembg_mobil.car_is_done.connect(_on_car_done)
	#$Itembg_pembajak.membajak_is_done.connect(_on_membajak_done)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_sawah_change_state(state):
	match state :
		"growth" : 
			pass
		"plow" :
			pass
		"ready_to_harvest" :
			if(IS_CAR_READY) : 
				$Subarea_sawah.set_sawah_state_idle()
				$Itembg_mobil.set_mobil_state_move()

func _on_car_done():
	pass
	#$Itembg_pembajak.behaviour_membajak()

func _on_membajak_done():
	$Subarea_sawah.set_sawah_state_growth()
