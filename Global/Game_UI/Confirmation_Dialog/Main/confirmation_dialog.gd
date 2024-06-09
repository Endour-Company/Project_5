extends Control

# Onready variables
@onready var SFX : AudioStreamPlayer = $SFX


# Custom signals
signal confirmed
signal close_signal


func _ready():
	# Set SFX volume
	SFX.set_volume_db(GameAudio.get_volume_sfx())


# Handle yes button click
func _on_yes_button_pressed():
	# Play click sfx
	GameAudio.play(SFX, GameAudio.SFX_Gameplay_Click)
	
	# Emit signal
	confirmed.emit()


func _on_no_button_pressed():
	# Play click sfx
	GameAudio.play(SFX, GameAudio.SFX_Gameplay_Click)
	await get_tree().create_timer(0.2).timeout
	
	# Send signal to free node
	close_signal.emit()
