extends Node2D


# Called when the node enters the scene tree for the first time.

var sceneWave  = preload("res://Game/Area_hutan/Lib/item_bg_wave/wave.tscn")

var WAVE_COUNT : int = 0

func _ready():
	WAVE_COUNT = $Waves.get_child_count()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	WAVE_COUNT = $Waves.get_child_count()
	if WAVE_COUNT < 3 : 
		var wave = sceneWave.instantiate()
		$Waves.add_child(wave)
		
