extends Node2D


var VAR_KUALITAS_PADI = 0
var VAR_KUANTITAS_PADI = 0

func _ready():
	$Subarea_sawah.sawah_ready_to_harvest.connect(_on_sawah_ready_to_harvest)
	$Itembg_mobil.car_is_done.connect(_on_car_done)
	

func _process(delta):
	pass

func _on_sawah_ready_to_harvest():

	var isCarReady = $Itembg_mobil.IS_CAR_READY
	if(isCarReady == true) : 

		$Itembg_mobil.CAR_STATE = $Itembg_mobil.CAR_STATES.MOVE
		$Subarea_sawah.SAWAH_STATE = $Subarea_sawah.SAWAH_STATES.IDLE

func _on_car_done():
	$Subarea_sawah/Itembg_pembajak.behaviour_membajak()

func _on_membajak_done():
	$Subarea_sawah.set_sawah_state_growth()

