extends Node2D

const Star = preload("res://Global/Game_UI/StarEffect/Lib/star_animation.gd")
const starAnimPath : String = "res://Global/Game_UI/StarEffect/Lib/star_animation.tscn"

func spawn(leftpos: Vector2, rightpos: Vector2):
	# Create star on left side
	var star1 : Node2D = preload(starAnimPath).instantiate()
	star1.init(leftpos, Star.LEFT)
	
	# Create star on right side
	var star2 : Node2D = preload(starAnimPath).instantiate()
	star2.init(rightpos, Star.RIGHT)
	
	# Spawn stars
	add_sibling(star1)
	add_sibling(star2)
	
	# Free self
	queue_free()
