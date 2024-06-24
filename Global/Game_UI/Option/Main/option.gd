extends Control

signal bgm_changed
signal sfx_changed
signal close_signal
signal tutorial_signal
signal exit_signal

func _ready():
	# Set BGM and SFX initial slider value
	$BGMSlider.set_value_no_signal(GameAudio.from_db(GameAudio.get_volume_bgm()))
	$SFXSlider.set_value_no_signal(GameAudio.from_db(GameAudio.get_volume_sfx()))
	
func _on_bgm_slider_value_changed(value):
	bgm_changed.emit(value)

func _on_sfx_slider_value_changed(value):
	sfx_changed.emit(value)

func _on_close_button_pressed():
	close_signal.emit()


func _on_tutorial_button_pressed():
	tutorial_signal.emit()


func _on_exit_button_pressed():
	exit_signal.emit()
