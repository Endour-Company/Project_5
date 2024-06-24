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
var LOGGING_VOLUME = 1 # Range : 1-5

# Called when the node enters the scene tree for the first time.

signal money_changed

func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func set_money(action : String, value : int):
	match action : 
		"min" :
			MONEY -= value
		"plus" :
			MONEY += value
	emit_signal("money_changed")

func set_logging_volume(value : int):
	LOGGING_VOLUME = value



