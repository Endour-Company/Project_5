extends Control


# Called when the node enters the scene tree for the first time.

@export var LOGGING_VOLUME_VALUE : int = 1
@export var LOGGING_VOLUME_MAX_VALUE : int = 5

signal logging_volume_changed(value : int)

func _ready():
	$Label.set_text(str(LOGGING_VOLUME_VALUE))
	logging_volume_changed.connect(_on_logging_volume_changed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_minus_pressed():
	if(LOGGING_VOLUME_VALUE - 1 > 0) :
		LOGGING_VOLUME_VALUE -= 1
	emit_signal("logging_volume_changed", LOGGING_VOLUME_VALUE)


func _on_button_plus_pressed():
	if(LOGGING_VOLUME_VALUE + 1 <= LOGGING_VOLUME_MAX_VALUE) :
		LOGGING_VOLUME_VALUE += 1
	emit_signal("logging_volume_changed", LOGGING_VOLUME_VALUE)

func _on_logging_volume_changed(value):
	$Label.set_text(str(value))
