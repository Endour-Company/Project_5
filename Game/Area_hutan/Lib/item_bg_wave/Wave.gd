extends CharacterBody2D


# Called when the node enters the scene tree for the first time.
var imgWave1 : Texture2D = preload("res://Game/Area_hutan/Assets/other/wave1.png")
var imgWave2 : Texture2D = preload("res://Game/Area_hutan/Assets/other/wave2.png")


var POINTS = [
	{
		"start" : Vector2(1391, -129),
		"end" : Vector2(2034, 1049)
 	},
	{
		"start" : Vector2(1256, -145),
		"end" : Vector2(2002, 1223)
 	},
	{
		"start" : Vector2(1272, -145),
		"end" : Vector2(2014, 1087)
 	},
]

var IMG_WAVES = [imgWave1, imgWave2]

var IMG_WAVE = null
var POINT = null

@export var TRAVEL_TIME : float = randf_range(15,30)# waktu untuk sampai ke tujuan
var ELAPSED_TIME : float = 0.0 # waktu yang telah berlalu

func _ready():
	POINT = Utils.get_random_item_from_array(POINTS)
	IMG_WAVE = Utils.get_random_item_from_array(IMG_WAVES)
	$Sprite2D.texture = IMG_WAVE 
	position = POINT["start"]
	velocity = (POINT["end"] - POINT["start"]).normalized() * ((POINT["end"] - POINT["start"]).length() / TRAVEL_TIME)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if ELAPSED_TIME < TRAVEL_TIME:
		ELAPSED_TIME += delta
		move_and_slide()
	else:
		queue_free()
