extends Node2D


# Called when the node enters the scene tree for the first time.

var VAR_KUALITAS_PADI = 0
var VAR_KUANTITAS_PADI = 0
var VAR_JUMLAH_HAMA = 0
var VAR_TINGKAT_PESTISIDA = 0


func _ready():
	$Subarea_sawah.sawah_change_state.connect(_on_sawah_change_state)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_sawah_change_state(state):
	match state :
		"growth" : 
			pass
		"plow" :
			print("logic for plow")
		"ready_to_harvest" :
			print("logic for harvest")


