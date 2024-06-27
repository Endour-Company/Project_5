extends CharacterBody2D


var textureTrash1 : Texture2D = load("res://Game/Global/Assets/Trash/Sampah Botol.png")
var textureTrash2 : Texture2D = load("res://Game/Global/Assets/Trash/Sampah Plastik.png")


var VELOCITY_TRASH : float = 10
var TRASH_SCALE : float = 0.25
var POINT_BEGIN : Vector2 = Vector2(0,0)
var POINT_END : Vector2 = Vector2(100,0)
var CURRENT_TIME : float = 0
var POINTS = [
	{
		"start" : Vector2(200, 100),
		"end" : Vector2(1930, 100),
		"velocity": 3
	},
	{
		"start" : Vector2(200, 120),
		"end" : Vector2(1930, 120),
		"velocity": 3
	},
	{
		"start" : Vector2(200, 90),
		"end" : Vector2(1930, 90),
		"velocity": 3
	},
	{
		"start" : Vector2(130, 700),
		"end" : Vector2(195, 360),
		"velocity": 6
	},
	{
		"start" : Vector2(120, 700),
		"end" : Vector2(185, 360),
		"velocity": 6
	},
]
var POINT

var TEXTURE_TRASH : Texture2D = Utils.get_random_item_from_array([textureTrash1, textureTrash2])
var TRASH_SCALE_VECTOR : Vector2 = Vector2(Vector2.ZERO)
var JOURNEY_LENGTH : float = POINT_BEGIN.distance_to(POINT_END)


func _ready():
	POINT = Utils.get_random_item_from_array(POINTS)
	TRASH_SCALE_VECTOR = Vector2(TRASH_SCALE, TRASH_SCALE)
	$Sprite2D.set_texture(TEXTURE_TRASH)
	set_position(POINT["start"])
	$Sprite2D.set_modulate(Color(1, 1, 1, 0))
	$Sprite2D.set_scale(TRASH_SCALE_VECTOR)
	VELOCITY_TRASH = POINT["velocity"]

func _physics_process(delta):
	var progress = CURRENT_TIME / (JOURNEY_LENGTH / VELOCITY_TRASH)
	position = POINT["start"].lerp(POINT["end"], progress)
	CURRENT_TIME += delta
	
	# Update alpha for fade in and fade out
	if progress < 0.1:  # Fade in for the first 10% of the journey
		$Sprite2D.modulate.a = progress * 5
	elif progress > 0.9:  # Fade out for the last 10% of the journey
		$Sprite2D.modulate.a = (1 - progress) * 5
	else:
		$Sprite2D.modulate.a = 0.5 # Fully visible

	# Check if the TRASH has reached the end point
	if progress >= 1:
		queue_free()  # Remove the TRASH node from the scene
