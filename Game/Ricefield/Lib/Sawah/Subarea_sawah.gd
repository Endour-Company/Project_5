extends Node2D


# Called when the node enters the scene tree for the first time.

var padisSmall = load("res://Game/Ricefield/Assets/item_bg_padi/padis_kecil.png")
var padisMedium = load("res://Game/Ricefield/Assets/item_bg_padi/padis_sedang.png")
var padisHigh = load("res://Game/Ricefield/Assets/item_bg_padi/padis_besar.png")

@export var GROWTH_SPEED : float = 1
var PADIS_SIZE = PADIS_SIZES.NONE
@export var SAWAH_STATE = SAWAH_STATES.GROWTH 

signal sawah_change_state(state)


enum PADIS_SIZES {
	NONE,
	SMALL,
	MEDIUM,
	HIGH
}

enum SAWAH_STATES {
	IDLE,
	PLOW,
	READY_TO_HARVEST,
	GROWTH,
}

var TIME_ELAPSED = 0

func _ready():
	set_padis_texture()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
		match SAWAH_STATE :
			SAWAH_STATES.IDLE :
				pass
			SAWAH_STATES.GROWTH:
				TIME_ELAPSED += delta * GROWTH_SPEED
				set_padis_growth()
			SAWAH_STATES.PLOW :
				pass
			SAWAH_STATES.READY_TO_HARVEST :
				set_sawah_state_ready_to_harvest()
			
func set_padis_growth():
	# Update PADIS_SIZE based on elapsed time
	if TIME_ELAPSED >= 5 and PADIS_SIZE == PADIS_SIZES.NONE:
		PADIS_SIZE = PADIS_SIZES.SMALL
		set_padis_texture()

	elif TIME_ELAPSED >= 30 and PADIS_SIZE == PADIS_SIZES.SMALL:
		PADIS_SIZE = PADIS_SIZES.MEDIUM
		set_padis_texture()
	elif TIME_ELAPSED >= 50 and PADIS_SIZE == PADIS_SIZES.MEDIUM:
		PADIS_SIZE = PADIS_SIZES.HIGH
		set_padis_texture()
	elif TIME_ELAPSED >= 80 and PADIS_SIZE == PADIS_SIZES.HIGH:
		SAWAH_STATE = SAWAH_STATES.READY_TO_HARVEST
		TIME_ELAPSED = 0

func set_padis_texture():
	match PADIS_SIZE:
		PADIS_SIZES.NONE :
			$TextureRect.set_texture(null)
		PADIS_SIZES.SMALL :
			$TextureRect.set_texture(padisSmall)
		PADIS_SIZES.MEDIUM :
			$TextureRect.set_texture(padisMedium)
		PADIS_SIZES.HIGH :
			$TextureRect.set_texture(padisHigh)


func set_sawah_state_idle():
	SAWAH_STATE = SAWAH_STATES.IDLE
	emit_signal("sawah_change_state", SAWAH_STATE)

func set_sawah_state_growth():
	SAWAH_STATE = SAWAH_STATES.GROWTH
	emit_signal("sawah_change_state", SAWAH_STATE)
	
func set_sawah_state_plow():
	SAWAH_STATE = SAWAH_STATES.PLOW
	emit_signal("sawah_change_state", "plow")

func set_sawah_state_ready_to_harvest():
	emit_signal("sawah_change_state", "ready_to_harvest")
