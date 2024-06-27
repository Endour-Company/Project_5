extends Control

@onready var SFX = $SFX

signal close_signal
signal area_hutan
signal area_sawah
signal area_pemukiman
signal area_pusatdesa

func _ready():
	SFX.set_volume_db(GameAudio.get_volume_sfx())

func play_click_sfx():
	GameAudio.play(SFX, GameAudio.SFX_Gameplay_Click)
	
func play_hover_sfx():
	GameAudio.play(SFX, GameAudio.SFX_Gameplay_Hover)

func _on_close_button_pressed():
	play_click_sfx()
	close_signal.emit()


func _on_government_pressed():
	play_click_sfx()
	area_pusatdesa.emit()


func _on_houses_pressed():
	play_click_sfx()
	area_pemukiman.emit()


func _on_ricefield_pressed():
	play_click_sfx()
	area_sawah.emit()


func _on_forest_pressed():
	play_click_sfx()
	area_hutan.emit()
