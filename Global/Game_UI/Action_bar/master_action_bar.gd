extends Control


var sceneBuyConfirmation = preload("res://Global/Game_UI/Action_bar/Buy_confirmation/Buy_confirmation.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_buy_button_pressed():
	var parent = get_parent()
	var buyConfirmation = sceneBuyConfirmation.instantiate()
	parent.add_child(buyConfirmation)
	

