extends TextureButton

var username : String
var time : String
var totalMoney : String
var happiness : String
var health : String
@onready var SFX = $SFX

func _ready():
	# Set initial SFX volume
	SFX.set_volume_db(GameAudio.get_volume_sfx())
	
	# Set values
	$MarginContainer/VBoxContainer/HBoxContainer/Name.set_text(username)
	$MarginContainer/VBoxContainer/HBoxContainer/Time.set_text(time)
	$MarginContainer/VBoxContainer/HBoxContainer2/HBoxContainer/TotalMoney.set_text(totalMoney)
	$MarginContainer/VBoxContainer/HBoxContainer2/HBoxContainer2/PercentageHappy.set_text(happiness)
	$MarginContainer/VBoxContainer/HBoxContainer2/HBoxContainer2/PercentageHealth.set_text(health)


func _on_mouse_entered():
	# Play hover sfx
	GameAudio.play(SFX, GameAudio.SFX_MainMenu_Hover)


func _on_pressed():
	# Play click sfx
	GameAudio.play(SFX, GameAudio.SFX_MainMenu_Click)
