extends Node2D

const starEffectPath = "res://Global/Game_UI/StarEffect/Main/star_effect.tscn"

# Called when the node enters the scene tree for the first time.
func _ready():
	# Define star position
	var leftpos = Vector2(50, 200)
	var rightpos = Vector2(800, 200)
	
	# Initialize star effect scene
	var starScene = preload(starEffectPath).instantiate()
	add_child(starScene)
	starScene.spawn(leftpos, rightpos)
