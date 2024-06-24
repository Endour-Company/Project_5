extends TextureButton

# Textures for pause button
@onready var pauseTextureNormal = preload("res://Global/Game_UI/In_game_menu/Assets/Pause Button_Normal.png")
@onready var pauseTextureHover = preload("res://Global/Game_UI/In_game_menu/Assets/Pause Button_Hover.png")
@onready var pauseTexturePressed = preload("res://Global/Game_UI/In_game_menu/Assets/Pause Button_Pressed.png")
@onready var resumeTextureNormal = preload("res://Global/Game_UI/In_game_menu/Assets/Resume Button_Normal.png")
@onready var resumeTextureHover = preload("res://Global/Game_UI/In_game_menu/Assets/Resume Button_Hover.png")
@onready var resumeTexturePressed = preload("res://Global/Game_UI/In_game_menu/Assets/Resume Button_Pressed.png")

func _process(delta):
	# Check if game is paused, and change texture accordingly
	if Variables.is_paused() :
		self.set_texture_normal(resumeTextureNormal)
		self.set_texture_hover(resumeTextureHover)
		self.set_texture_pressed(resumeTexturePressed)
	else:
		self.set_texture_normal(pauseTextureNormal)
		self.set_texture_hover(pauseTextureHover)
		self.set_texture_pressed(pauseTexturePressed)
