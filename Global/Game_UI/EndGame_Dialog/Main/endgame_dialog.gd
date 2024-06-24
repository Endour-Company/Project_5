extends Control

signal view_scoreboard

func _on_view_scoreboard_button_pressed():
	view_scoreboard.emit()
