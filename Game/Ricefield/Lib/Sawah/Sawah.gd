extends Node2D


var GROWTH_SPEED = 1
var PADIS_SIZE = PADIS_SIZES.NONE
var SAWAH_STATE = SAWAH_STATES.IDLE

enum PADIS_SIZES {
	NONE,
	SMALL,
	MEDIUM,
	HIGH
}

enum SAWAH_STATES {
	IDLE,
	UPGRADING
}

var padisSmall = load("res://Game/Ricefield/Assets/item_bg_padi/Padis_kecil.png")
var padisMedium = load("res://Game/Ricefield/Assets/item_bg_padi/Padis_sedang.png")
var padisHigh = load("res://Game/Ricefield/Assets/item_bg_padi/Padis_besar.png")


var TIME_ELAPSED = 0

func _ready():
	set_padis_texture()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	TIME_ELAPSED += delta * GROWTH_SPEED
	print(TIME_ELAPSED)
	
	# Update PADIS_SIZE based on elapsed time
	if TIME_ELAPSED >= 5 and PADIS_SIZE == PADIS_SIZES.NONE:
		PADIS_SIZE = PADIS_SIZES.SMALL
		set_padis_texture()
		effect_upgrading()
	elif TIME_ELAPSED >= 30 and PADIS_SIZE == PADIS_SIZES.SMALL:
		PADIS_SIZE = PADIS_SIZES.MEDIUM
		set_padis_texture()
	elif TIME_ELAPSED >= 50 and PADIS_SIZE == PADIS_SIZES.MEDIUM:
		PADIS_SIZE = PADIS_SIZES.HIGH
		set_padis_texture()
	elif TIME_ELAPSED >= 80 and PADIS_SIZE == PADIS_SIZES.HIGH:
		PADIS_SIZE = PADIS_SIZES.NONE
		set_padis_texture()
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

func effect_upgrading():
	pass
