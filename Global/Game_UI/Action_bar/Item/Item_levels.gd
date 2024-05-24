extends HBoxContainer


# Called when the node enters the scene tree for the first time.

@onready  var LEVEL_SCENE = preload("res://Global/Game_UI/Action_bar/Level/level.tscn")

var CURRENT_LEVEL = 1
var LEVELS_COUNT = 1
func _ready():

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func init_level(currentLevel:int, levelsCount:int):
	refresh()
	for count in levelsCount:
		var level = count+1
		var levelScene = LEVEL_SCENE.instantiate()
		
		if(level <= currentLevel):
			levelScene.init_level(level,true)
		else:
			levelScene.init_level(level,false)
		
		add_child(levelScene)

func refresh():
	for child in get_children():
		child.queue_free()
