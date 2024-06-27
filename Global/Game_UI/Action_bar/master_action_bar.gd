extends Control


var sceneBuyConfirmation = preload("res://Global/Game_UI/Action_bar/Buy_confirmation/Buy_confirmation.tscn")
@onready var SFX = $Action_bar/SFX
@onready var SFX2 = $Action_bar/SFX2

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_buy_button_pressed():
	# Play money sfx
	SFX.set_volume_db(GameAudio.get_volume_sfx())
	SFX2.set_volume_db(GameAudio.get_volume_sfx())
	GameAudio.play(SFX, GameAudio.SFX_Cashier)
	
	var _on_buy_confirmed = func _buy_sfx():
		GameAudio.play(SFX2, GameAudio.SFX_Upgrade)
		
	var _on_buy_cancel = func _cancel_sfx():
		GameAudio.play(SFX2, GameAudio.SFX_Gameplay_Click)
	
	var parent = get_parent()
	var buyConfirmation = sceneBuyConfirmation.instantiate()
	buyConfirmation.connect("buy_signal", _on_buy_confirmed)
	buyConfirmation.connect("close_signal", _on_buy_cancel)
	parent.add_child(buyConfirmation)
	


func _on_buy_button_mouse_entered():
	# Play hover SFX
	SFX.set_volume_db(GameAudio.get_volume_sfx())
	GameAudio.play(SFX, GameAudio.SFX_Gameplay_Hover)
