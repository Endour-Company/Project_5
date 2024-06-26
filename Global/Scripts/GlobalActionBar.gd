extends Node


# Called when the node enters the scene tree for the first time.

var CURRENT_SELECTED_ITEM = null

signal current_selected_item_changed(selected_item_name : String)

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func set_selected_item(selected_item_name : String):
	CURRENT_SELECTED_ITEM = selected_item_name
	emit_signal("current_selected_item_changed", selected_item_name)
