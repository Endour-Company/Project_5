extends "res://Game/Global/Scripts/Base_sungai.gd"


# Called when the node enters the scene tree for the first time.

var sceneWave  = preload("res://Game/Area_hutan/Lib/item_bg_wave/wave.tscn")

var WAVE_COUNT : int = 0

func _ready():
	TEXTURE_NODE = $TextureRect
	textureSungaiKotor  = load("res://Game/Area_hutan/Assets/item_bg_sungai/sungai_kotor.png")
	textureSungaiNormal = load("res://Game/Area_hutan/Assets/item_bg_sungai/sungai_normal.png")
	textureSungaiBerkilau = load("res://Game/Area_hutan/Assets/item_bg_sungai/sungai_berkilau.png")
	
	
	WAVE_COUNT = $Waves.get_child_count()

	super._ready()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	WAVE_COUNT = $Waves.get_child_count()
	if WAVE_COUNT < 3 : 
		var wave = sceneWave.instantiate()
		$Waves.add_child(wave)
	
	super._process(delta)
