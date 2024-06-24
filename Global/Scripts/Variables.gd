extends Node


@export var MONEY : int = 50000000000

# AREA : ALL (Range 0-1)
var VAR_KUALITAS_AIR = 0.6
var VAR_PENDAPATAN = 0
var VAR_KESEHATAN_MASYARAKAT = 0
var VAR_KESEJAHTERAAN_MASYARAKAT = 0

# AREA : SAWAH
var GROWTH_SPEED =  1 # Range  : 0-1

# AREA : HUTAN
var LOGGING_VOLUME = 1 # Range : 0-5
var MAX_COUNT_POHON = 11
var COUNT_POHON = 1

# AREA : PUSAT DESA
var MAX_LEVEL_OF_PASAR = 3

# AREA : PEMUKIMAN
var MAX_COUNT_OF_SEPTIC_TANK = 3 
var MAX_COUNT_OF_TOILET = 6

# Called when the node enters the scene tree for the first time.

signal money_changed

func _ready():
	var x : float = 1
	var y : float = 4
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Set GROWTH_SPEED based on KUALITAS_AIR
	GROWTH_SPEED = calculate_growth_speed(VAR_KUALITAS_AIR)
	watch_kualtas_air()


func set_money(action : String, value : int):
	match action : 
		"min" :
			MONEY -= value
		"plus" :
			MONEY += value
	emit_signal("money_changed")

func set_logging_volume(value : int):
	LOGGING_VOLUME = value

func calculate_growth_speed(kualitas_air: float) -> float:
	# Jika kualitas_air = 0, growth_speed adalah nilai minimal yaitu 0.5
	if kualitas_air == 0:
		return 0.5
	# Jika kualitas_air > 0, growth_speed dihitung sebagai berikut:
	# growth_speed = 0.5 * kualitas_air + 0.5
	return 0.5 * kualitas_air + 0.5


func watch_kualtas_air():
	var kualitasAir = 0
	
	var normalizedCountPohon : float = COUNT_POHON / float(MAX_COUNT_POHON)
	var normalizedLevelOfPasar : float = (Utils.find_item_in_array_with_key(GlobalItemsLevel.ITEM_LEVEL, "name", "Pasar"))["level"] / float(MAX_LEVEL_OF_PASAR)
	var normalizedCountOfSeptictank : float  = (Utils.find_item_in_array_with_key(GlobalItemsLevel.ITEM_LEVEL, "name", "Septic Tank"))["level"] / float(MAX_COUNT_OF_SEPTIC_TANK)
	var normalizedCountOfToilet: float  = (Utils.find_item_in_array_with_key(GlobalItemsLevel.ITEM_LEVEL, "name", "Toilet Umum"))["level"] / float(MAX_COUNT_OF_TOILET)
	
	for variable in [normalizedCountPohon, normalizedLevelOfPasar, normalizedCountOfSeptictank, normalizedCountOfToilet] :
		kualitasAir += variable/4
	
	VAR_KUALITAS_AIR = kualitasAir
