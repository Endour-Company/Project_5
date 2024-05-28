extends Node2D


@export var GROWTH_SPEED : float = 1
var PADIS_SIZE = PADIS_SIZES.NONE
@export var SAWAH_STATE = SAWAH_STATES.GROWTH 

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

var padisSmall = load("res://Game/Ricefield/Assets/item_bg_padi/Padis_kecil.png")
var padisMedium = load("res://Game/Ricefield/Assets/item_bg_padi/Padis_sedang.png")
var padisHigh = load("res://Game/Ricefield/Assets/item_bg_padi/Padis_besar.png")


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

func set_sawah_state_growth():
	SAWAH_STATE = SAWAH_STATES.GROWTH
	
func set_sawah_state_plow():
	SAWAH_STATE = SAWAH_STATES.PLOW
