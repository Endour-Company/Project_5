
extends Control


# Called when the node enters the scene tree for the first time.

var PESTISIDA_VOLUME_VALUE : int = Variables.PESTISIDA_VOLUME
@export var PESTISIDA_VOLUME_MAX_VALUE : int = 3

signal pestisida_volume_changed(value : int)

func _ready():
	$Label.set_text(str(PESTISIDA_VOLUME_VALUE))
	pestisida_volume_changed.connect(_on_pestisida_volume_changed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_minus_pressed():
	if(PESTISIDA_VOLUME_VALUE - 1 >= 0) :
		PESTISIDA_VOLUME_VALUE -= 1
		Variables.PESTISIDA_VOLUME = PESTISIDA_VOLUME_VALUE
	emit_signal("pestisida_volume_changed", PESTISIDA_VOLUME_VALUE)


func _on_button_plus_pressed():
	if(PESTISIDA_VOLUME_VALUE + 1 <= PESTISIDA_VOLUME_MAX_VALUE) :
		PESTISIDA_VOLUME_VALUE += 1
		Variables.PESTISIDA_VOLUME = PESTISIDA_VOLUME_VALUE
		emit_signal("pestisida_volume_changed", PESTISIDA_VOLUME_VALUE)

func _on_pestisida_volume_changed(value):
	$Label.set_text(str(value))

