extends Control

signal close_signal

func _on_close_button_pressed():
	close_signal.emit()
