extends Node2D

enum {
	LEFT,
	RIGHT
}

# Custom inititialize method
func init(pos: Vector2, orientation: int):
	# Set initial position
	self.set_position(pos)
	
	# Play animation according to orientation
	match orientation:
		LEFT:
			$AnimationPlayer.play("jump_left")
		RIGHT:
			$AnimationPlayer.play("jump_right")


func _on_animation_player_animation_finished(anim_name):
	queue_free()
