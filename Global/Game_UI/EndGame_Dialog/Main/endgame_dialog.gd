extends Control

@onready var SFX = $SFX
signal view_scoreboard

func _ready():
	SFX.set_volume_db(GameAudio.get_volume_sfx())

func _on_view_scoreboard_button_pressed():
	GameAudio.play(SFX, GameAudio.SFX_Gameplay_Click)
	view_scoreboard.emit()


func _on_view_scoreboard_button_mouse_entered():
	GameAudio.play(SFX, GameAudio.SFX_Gameplay_Hover)
