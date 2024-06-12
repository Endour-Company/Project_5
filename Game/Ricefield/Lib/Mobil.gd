extends Node2D


# Called when the node enters the scene tree for the first time.
var imgMobilKosong : Texture2D = preload("res://Game/Ricefield/Assets/item_bg_mobil/mobil_kosong.png")
var imgMobilIsi : Texture2D = preload("res://Game/Ricefield/Assets/item_bg_mobil/mobil_isi.png")

var POS_INIT_IDLE = Vector2(0,0)

var CAR_VELOCITIES_BASED_ON_JALAN_SAWAH = [
	{
		"level" : 1,
		"velocity" : 50
	},
	{
		"level" : 2,
		"velocity" : 150
	},
	{
		"level" : 3,
		"velocity" : 300	
	}
]

@export var CAR_VELOCITY : float = 600
@export var SHAKE_AMPLITUDE : float = 2  # Amplitudo getaran (ke atas dan ke bawah)
@export var SHAKE_SPEED : float = 15      # Kecepatan getaran


# If car not ready, car cant be distracted while car in MOVE state
var IS_CAR_READY = true

signal car_is_done

enum CAR_STATES {
	IDLE,
	MOVE,
}

var CAR_STATE = CAR_STATES.IDLE
var CAR_DONE  = false
var shake_timer = 0.0




func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	match CAR_STATE :
		CAR_STATES.IDLE :
			idle_state()
		CAR_STATES.MOVE :
			move_state(delta)
			


func idle_state():
	$CharacterBody2D/Sprite2D.set_texture(imgMobilKosong)
	$CharacterBody2D.set_global_position(POS_INIT_IDLE)


func move_state(delta):
	watch_jalan_sawah_level()
	if($CharacterBody2D.position.x >= 1920):
		$CharacterBody2D.position.x = -500
		CAR_DONE = true
	if (!CAR_DONE) :
		$CharacterBody2D/Sprite2D.set_texture(imgMobilIsi)
		$CharacterBody2D.velocity = Vector2(CAR_VELOCITY,0)
	else :
		$CharacterBody2D/Sprite2D.set_texture(imgMobilKosong)
		if($CharacterBody2D.position >= Vector2(Vector2.ZERO)):
			emit_signal("car_is_done")
			set_mobil_state_idle()
	
	$CharacterBody2D.move_and_slide()
	apply_shake_effect(delta)

func apply_shake_effect(delta):
	shake_timer += delta * SHAKE_SPEED
	var shake_offset = sin(shake_timer) * SHAKE_AMPLITUDE
	$CharacterBody2D/Sprite2D.position.y += shake_offset

func set_mobil_state_idle():
	CAR_DONE = false
	CAR_STATE = CAR_STATES.IDLE
	
func set_mobil_state_move():
	CAR_STATE = CAR_STATES.MOVE

func watch_jalan_sawah_level():
	var dataOfJalan = Utils.find_item_in_array_with_key(GlobalItemsLevel.ITEM_LEVEL, "name", "Jalan Sawah")
	var levelOfJalan = dataOfJalan["level"]
	var carVelocityBasedOnJalanLevel = Utils.find_item_in_array_with_key(CAR_VELOCITIES_BASED_ON_JALAN_SAWAH, "level", levelOfJalan)
	
	CAR_VELOCITY = carVelocityBasedOnJalanLevel["velocity"]
	
	
