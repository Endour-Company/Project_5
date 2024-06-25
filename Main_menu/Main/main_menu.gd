extends Control

# Define onready variables
@onready var nameInputScreen : Control
@onready var tutorialScreen : Control
@onready var optionScreen : Control
@onready var confirmScreen : Control
@onready var BGM : AudioStreamPlayer = $BGM
@onready var SFX : AudioStreamPlayer = $SFX
@onready var anim : AnimationPlayer = $AnimationPlayer

# Overlay
@onready var overlay = $IntroOverlay
var overlayPos = 0

# Custom signals
signal start_signal
signal exit_signal


func _ready():
	# Set BGM and SFX volume
	BGM.set_volume_db(GameAudio.get_volume_bgm())
	SFX.set_volume_db(GameAudio.get_volume_sfx())
	
	# Play Intro
	anim.play("Intro")


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
	
	# Show name input scene
	nameInputScreen = preload("res://Global/Game_UI/InputName/Main/inputname.tscn").instantiate()
	nameInputScreen.connect("input_complete", _on_input_complete)
	add_child(nameInputScreen)

func _on_input_complete():
	# Show overlay and play fade out animation before sending out start signal
	move_child(overlay, overlayPos)
	anim.play("Fade Out")
	
	# Delete name input screen
	nameInputScreen.queue_free()

func _on_tutorial_button_pressed():
	# Play click SFX
	GameAudio.play(SFX, GameAudio.SFX_MainMenu_Click)
	
	# Spawn tutorial screen
	tutorialScreen = preload("res://Global/Game_UI/Tutorial/Main/tutorial_book.tscn").instantiate()
	add_child(tutorialScreen)
	tutorialScreen.connect("close_signal", _on_tutorial_closed)


func _on_tutorial_closed():
	# Play close SFX
	GameAudio.play(SFX, GameAudio.SFX_MainMenu_Close)
	
	# Kill tutorial screen
	tutorialScreen.queue_free()


func _on_skor_button_pressed():
	# Play click SFX
	GameAudio.play(SFX, GameAudio.SFX_MainMenu_Click)


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
	
	# Spawn confirm screen
	confirmScreen = preload("res://Global/Game_UI/Confirmation_Dialog/Main/confirmation_dialog_no_sub.tscn").instantiate()
	add_child(confirmScreen)
	confirmScreen.connect("close_signal", _on_confirm_closed)
	

func _on_confirm_closed():
	# Play close SFX
	GameAudio.play(SFX, GameAudio.SFX_MainMenu_Close)
	
	# Kill confirm screen
	confirmScreen.queue_free()
	
	# Send exit signal
	exit_signal.emit()


# Handle animation finished
func _on_animation_player_animation_finished(anim_name):
	match anim_name:
		"Intro":
			# Free the intro logo
			$IntroLogo.queue_free()
			
			# Hide intro overlay
			overlayPos = overlay.get_index()
			move_child(overlay, 0)
			
			# Play BGM
			GameAudio.play(BGM, GameAudio.BGM_MainMenu)
		"Fade Out":
			# Send start signal
			start_signal.emit()
