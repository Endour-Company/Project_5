extends Control

signal close_signal
signal tutorial_signal
signal exit_signal

func _on_close_button_pressed():
	close_signal.emit()


func _on_tutorial_button_pressed():
	tutorial_signal.emit()


func _on_exit_button_pressed():
	exit_signal.emit()
