extends Control

# Define onready variables
@onready var overlay : ColorRect = $Overlay
@onready var tutorialScreen : Control


func _ready():
	# Hide overlay
	overlay.visible = false


func _on_mulai_button_pressed():
	pass # Replace with function body.


func _on_tutorial_button_pressed():
	# Show overlay
	overlay.visible = true
	
	# Spawn tutorial screen
	tutorialScreen = preload("res://Main_menu/Lib/tutorial_book.tscn").instantiate()
	add_child(tutorialScreen)
	tutorialScreen.connect("exit_signal", _on_tutorial_closed)


func _on_tutorial_closed():
	# Kill tutorial screen
	tutorialScreen.queue_free()
	
	# Hide overlay
	overlay.visible = false


func _on_opsi_button_pressed():
	pass # Replace with function body.


func _on_keluar_button_pressed():
	pass # Replace with function body.
