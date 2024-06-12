extends Node2D


# Called when the node enters the scene tree for the first time.
var SCENE_WAVE = preload("res://Game/Global/Lib/Wave/wave.tscn")

func _ready():
	spawn_wave1()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	

func spawn_wave1() :
	var timer = Timer.new()
	timer.set_wait_time(10)
	timer.set_autostart(true)
	add_child(timer)
	timer.start()
	print("timer started")
	
	var on_timeout = func on_timeout():
		var sceneWave = SCENE_WAVE.instantiate()
		sceneWave.WAVE_SCALE = 0.4
		var pointY = randi_range(430,480)
		sceneWave.POINT_BEGIN = Vector2(-37,pointY)
		sceneWave.POINT_END = Vector2(182,pointY)
		add_child(sceneWave)
		spawn_wave2(Vector2(274,483), Vector2(370,236), Vector2(156,727))
	
	timer.connect("timeout",on_timeout)
	
func spawn_wave2(border1 : Vector2 , border2 : Vector2, border3 : Vector2):
	for border : Vector2 in [border1,border2,border3] :
		var sceneWave = SCENE_WAVE.instantiate()
		sceneWave.WAVE_SCALE = 0.1
		sceneWave.POINT_BEGIN = border
		sceneWave.POINT_END = Vector2(border.x + 850,border.y)
		add_child(sceneWave)
	

