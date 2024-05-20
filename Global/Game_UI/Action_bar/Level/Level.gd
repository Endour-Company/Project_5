extends MarginContainer


# Called when the node enters the scene tree for the first time.

var imgLv1 = load("res://Global/Game_UI/Action_bar/Assets/Level_text_1.png")
var imgLv2 = load("res://Global/Game_UI/Action_bar/Assets/Level_text_2.png")
var imgLv3 = load("res://Global/Game_UI/Action_bar/Assets/Level_text_3.png")

var imgUpgraded = load("res://Global/Game_UI/Action_bar/Assets/Level_bar_upgraded.png")
var imgNotUpgraded = load("res://Global/Game_UI/Action_bar/Assets/Level_bar_not_upgraded.png")



func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

		
func init_level(level:int, upgraded : bool):
	if upgraded:
		$Fill.set_texture(imgUpgraded)
	else :
		$Fill.set_texture(imgNotUpgraded)
	
	match level:
		1:
			$Text/TextureRect.set_texture(imgLv1)
		2:
			$Text/TextureRect.set_texture(imgLv2)
		3:
			$Text/TextureRect.set_texture(imgLv3)
