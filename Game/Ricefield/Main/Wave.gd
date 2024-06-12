extends CharacterBody2D


var textureWave1 : Texture2D = load("res://Game/Global/Assets/wave1.png")
var textureWave2 : Texture2D = load("res://Game/Global/Assets/wave2.png")


var VELOCITY_WAVE : float = 10
var WAVE_SCALE : float = 0.25
var POINT_BEGIN : Vector2 = Vector2(0,0)
var POINT_END : Vector2 = Vector2(100,0)
var CURRENT_TIME : float = 0


var TEXTURE_WAVE : Texture2D = Utils.get_random_item_from_array([textureWave1, textureWave2])
var WAVE_SCALE_VECTOR : Vector2 = Vector2(Vector2.ZERO)
var JOURNEY_LENGTH : float = POINT_BEGIN.distance_to(POINT_END)


func _ready():
	WAVE_SCALE_VECTOR = Vector2(WAVE_SCALE, WAVE_SCALE)
	$Sprite2D.set_texture(TEXTURE_WAVE)
	set_position(POINT_BEGIN)
	$Sprite2D.set_modulate(Color(1, 1, 1, 0))
	$Sprite2D.set_scale(WAVE_SCALE_VECTOR)

func _physics_process(delta):
	var progress = CURRENT_TIME / (JOURNEY_LENGTH / VELOCITY_WAVE)
	position = POINT_BEGIN.lerp(POINT_END, progress)
	CURRENT_TIME += delta
	
	# Update alpha for fade in and fade out
	if progress < 0.1:  # Fade in for the first 10% of the journey
		$Sprite2D.modulate.a = progress * 5
	elif progress > 0.9:  # Fade out for the last 10% of the journey
		$Sprite2D.modulate.a = (1 - progress) * 5
	else:
		$Sprite2D.modulate.a = 0.5 # Fully visible

	# Check if the wave has reached the end point
	if progress >= 1:
		queue_free()  # Remove the wave node from the scene
