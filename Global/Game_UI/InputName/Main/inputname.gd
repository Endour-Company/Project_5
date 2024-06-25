extends Control

@onready var SFX = $SFX

var inputName : String

signal input_complete

func _ready():
	SFX.set_volume_db(GameAudio.get_volume_sfx())

func _on_submit_button_pressed():
	# Play click SFX
	GameAudio.play(SFX, GameAudio.SFX_MainMenu_Click)
	
	# Get name
	inputName = $Box/LineEdit.get_text()
	
	# Validate input
	if validateName(inputName):
		GameAudio.play(SFX, GameAudio.SFX_Gameplay_Click)
		await get_tree().create_timer(0.2).timeout
		input_complete.emit()
		

func validateName(name: String):
	if name != "":
		return true
	return false
