extends Control

# Define onready variables
@onready var tutorialScreen : Control
@onready var optionScreen : Control


func _on_mulai_button_pressed():
	pass # Replace with function body.


func _on_tutorial_button_pressed():
	# Spawn tutorial screen
	tutorialScreen = preload("res://Main_menu/Lib/tutorial_book.tscn").instantiate()
	add_child(tutorialScreen)
	tutorialScreen.connect("close_signal", _on_tutorial_closed)


func _on_tutorial_closed():
	# Kill tutorial screen
	tutorialScreen.queue_free()


func _on_opsi_button_pressed():
	# Spawn option screen (no tutorial version)
	optionScreen = preload("res://Global/Game_UI/Option/option_no_tutorial.tscn").instantiate()
	add_child(optionScreen)
	optionScreen.connect("close_signal", _on_opsi_closed)
	

func _on_opsi_closed():
	# Kill option screen
	optionScreen.queue_free()


func _on_keluar_button_pressed():
	pass # Replace with function body.
