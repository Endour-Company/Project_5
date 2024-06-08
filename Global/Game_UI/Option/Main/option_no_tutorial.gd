extends Control

signal close_signal
signal bgm_changed(value : float)
signal sfx_changed(value : float)


func _ready():
	# Set BGM and SFX initial slider value
	$BGMSlider.set_value_no_signal(GameAudio.from_db(GameAudio.get_volume_bgm()))
	$SFXSlider.set_value_no_signal(GameAudio.from_db(GameAudio.get_volume_sfx()))
	print("BGM GET")
	print(GameAudio.from_db(GameAudio.get_volume_bgm()))


func _on_close_button_pressed():
	close_signal.emit()


func _on_bgm_slider_value_changed(value):
	print("BGM SET")
	print(value)
	bgm_changed.emit(value)


func _on_sfx_slider_value_changed(value):
	sfx_changed.emit(value)
