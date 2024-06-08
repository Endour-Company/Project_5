extends Control

# Define onready variables
@onready var tutorialScreen : Control
@onready var optionScreen : Control
@onready var BGM : AudioStreamPlayer = $BGM
@onready var SFX : AudioStreamPlayer = $SFX


func _ready():
	# Set BGM and SFX volume
	BGM.set_volume_db(GameAudio.get_volume_bgm())
	SFX.set_volume_db(GameAudio.get_volume_sfx())
	
	# Play BGM
	GameAudio.play(BGM, GameAudio.BGM_MainMenu)


# Handle button hovers
func _on_mulai_button_mouse_entered():
	GameAudio.play(SFX, GameAudio.SFX_MainMenu_Hover)
	

func _on_tutorial_button_mouse_entered():
	GameAudio.play(SFX, GameAudio.SFX_MainMenu_Hover)
	

func _on_opsi_button_mouse_entered():
	GameAudio.play(SFX, GameAudio.SFX_MainMenu_Hover)
	

func _on_keluar_button_mouse_entered():
	GameAudio.play(SFX, GameAudio.SFX_MainMenu_Hover)


# Handle button clicks
func _on_mulai_button_pressed():
	# Play Start SFX
	GameAudio.play(SFX, GameAudio.SFX_MainMenu_Click)


func _on_tutorial_button_pressed():
	# Play click SFX
	GameAudio.play(SFX, GameAudio.SFX_MainMenu_Click)
	
	# Spawn tutorial screen
	tutorialScreen = preload("res://Main_menu/Lib/tutorial_book.tscn").instantiate()
	add_child(tutorialScreen)
	tutorialScreen.connect("close_signal", _on_tutorial_closed)


func _on_tutorial_closed():
	# Play close SFX
	GameAudio.play(SFX, GameAudio.SFX_MainMenu_Close)
	
	# Kill tutorial screen
	tutorialScreen.queue_free()


func _on_opsi_button_pressed():
	# Play click SFX
	GameAudio.play(SFX, GameAudio.SFX_MainMenu_Click)
	
	# Spawn option screen (no tutorial version)
	optionScreen = preload("res://Global/Game_UI/Option/Main/option_no_tutorial.tscn").instantiate()
	add_child(optionScreen)
	optionScreen.connect("bgm_changed", _on_bgm_changed)
	optionScreen.connect("sfx_changed", _on_sfx_changed)
	optionScreen.connect("close_signal", _on_opsi_closed)
	

func _on_bgm_changed(value : float):
	GameAudio.set_volume_bgm(GameAudio.to_db(value))
	BGM.set_volume_db(GameAudio.get_volume_bgm())
	

func _on_sfx_changed(value : float):
	GameAudio.set_volume_sfx(GameAudio.to_db(value))
	SFX.set_volume_db(GameAudio.get_volume_sfx())


func _on_opsi_closed():
	# Play close SFX
	GameAudio.play(SFX, GameAudio.SFX_MainMenu_Close)
	
	# Kill option screen
	optionScreen.queue_free()


func _on_keluar_button_pressed():
	# Play click SFX
	GameAudio.play(SFX, GameAudio.SFX_MainMenu_Click)
