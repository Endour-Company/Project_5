extends Node


# BGM Asset References
const BGM_MainMenu : AudioStream = preload("res://Global/Game_Audio/Assets/BGM/BGM_Main Menu.ogg")


# SFX Asset References
const SFX_MainMenu_Hover : AudioStream = preload("res://Global/Game_Audio/Assets/SFX/General/Main Menu_Hover.wav")
const SFX_MainMenu_Click : AudioStream = preload("res://Global/Game_Audio/Assets/SFX/General/Main Menu_Click.wav")
const SFX_MainMenu_Close : AudioStream = preload("res://Global/Game_Audio/Assets/SFX/General/Main Menu_Close.wav")
const SFX_Tutorial_Open : AudioStream = preload("res://Global/Game_Audio/Assets/SFX/General/Tutorial_Open.wav")
const SFX_Tutorial_Click : AudioStream = preload("res://Global/Game_Audio/Assets/SFX/General/Tutorial_Click.wav")
const SFX_Gameplay_Click : AudioStream = preload("res://Global/Game_Audio/Assets/SFX/General/Gameplay_Click.wav")


# Audio volume variabels
var volume_BGM : float = -4.44
var volume_SFX : float = -1.94


# Volume variables getter
func get_volume_bgm():
	return volume_BGM

func get_volume_sfx():
	return volume_SFX


# Method to set volume variables
func set_volume_bgm(db : float):
	volume_BGM = db

func set_volume_sfx(db : float):
	volume_SFX = db


# Method to play audio
func play(player : AudioStreamPlayer, stream : AudioStream):
	player.set_stream(stream)
	player.play()


# Method to convert 0 - 100 to decibels (Godot's volume_db)
func to_db(value : float):
	if value <= 0:
		return -80  # Minimum volume in decibels
	elif value > 100:
		value = 100
	
	# Convert 0 - 100 value to decibels
	var linear : float = pow(value / 100.0, 0.25) # Convert to linear value of 0.0 - 1.0 with a curve
	return round(20 * log(linear))
	

# Method to convert decibels to linear volume
func from_db(db : float):
	if db <= -80:
		return 0
		
	# Convert db back to linear value
	var value : float = pow(10, db / 20.0)
	
	# Inverse curve
	value = pow(value, 4)
	
	return round(value * 100) * 2
