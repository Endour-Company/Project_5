extends Node2D


# Called when the node enters the scene tree for the first time.

var padisSmall = load("res://Game/Ricefield/Assets/item_bg_padi/padis_kecil.png")
var padisMedium = load("res://Game/Ricefield/Assets/item_bg_padi/padis_sedang.png")
var padisHigh = load("res://Game/Ricefield/Assets/item_bg_padi/padis_besar.png")

@export var GROWTH_SPEED : float = 1
var PADIS_SIZE = PADIS_SIZES.NONE

@export var SAWAH_STATE = SAWAH_STATES.IDLE 


signal sawah_ready_to_harvest

enum PADIS_SIZES {
	NONE,
	SMALL,
	MEDIUM,
	HIGH
}

enum SAWAH_STATES {
	IDLE,
	GROWTH,
	READY_TO_HARVEST,
}

var TIME_ELAPSED = 0

func _ready():
	$Itembg_pembajak.membajak_is_done.connect(_on_membajak_is_done)
	set_padis_texture()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
		match SAWAH_STATE :
			SAWAH_STATES.IDLE :
				TIME_ELAPSED = 0
				PADIS_SIZE = PADIS_SIZES.NONE
				set_padis_texture()
			SAWAH_STATES.GROWTH:
				TIME_ELAPSED += delta * GROWTH_SPEED
				set_sawah_growth()

			SAWAH_STATES.READY_TO_HARVEST :
				pass
			
func set_sawah_growth():
	var previous_size = PADIS_SIZE
	# Update PADIS_SIZE based on elapsed time
	if TIME_ELAPSED >= 5 and PADIS_SIZE == PADIS_SIZES.NONE:
		PADIS_SIZE = PADIS_SIZES.SMALL

	elif TIME_ELAPSED >= 30 and PADIS_SIZE == PADIS_SIZES.SMALL:
		PADIS_SIZE = PADIS_SIZES.MEDIUM

	elif TIME_ELAPSED >= 50 and PADIS_SIZE == PADIS_SIZES.MEDIUM:
		PADIS_SIZE = PADIS_SIZES.HIGH

	elif TIME_ELAPSED >= 80 and PADIS_SIZE == PADIS_SIZES.HIGH:
		if SAWAH_STATE != SAWAH_STATES.READY_TO_HARVEST: 
			SAWAH_STATE = SAWAH_STATES.READY_TO_HARVEST
			emit_signal("sawah_ready_to_harvest")
		TIME_ELAPSED = 0
	
	if previous_size != PADIS_SIZE:
		set_padis_texture()
		match PADIS_SIZE:
			PADIS_SIZES.NONE:
				SAWAH_STATE = SAWAH_STATES.IDLE
			PADIS_SIZES.SMALL, PADIS_SIZES.MEDIUM, PADIS_SIZES.HIGH:
				SAWAH_STATE = SAWAH_STATES.GROWTH


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


func _on_membajak_is_done():
	SAWAH_STATE = SAWAH_STATES.GROWTH
