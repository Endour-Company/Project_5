extends TextureButton

var username : String
var time : String
var totalMoney : String
var happiness : String
var health : String

func _ready():
	$MarginContainer/VBoxContainer/HBoxContainer/Name.set_text(username)
	$MarginContainer/VBoxContainer/HBoxContainer/Time.set_text(time)
	$MarginContainer/VBoxContainer/HBoxContainer2/HBoxContainer/TotalMoney.set_text(totalMoney)
	$MarginContainer/VBoxContainer/HBoxContainer2/HBoxContainer2/PercentageHappy.set_text(happiness)
	$MarginContainer/VBoxContainer/HBoxContainer2/HBoxContainer2/PercentageHealth.set_text(health)
