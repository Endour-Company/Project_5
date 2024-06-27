extends Control

var title
var desc

func _ready():
	$Box/Title.set_text(title)
	$Box/Desc.set_text(desc)
	
	self.position.y -= 20
	
	var tween = get_tree().create_tween()
	var tween2 = get_tree().create_tween()
	tween.tween_property(self, "position", Vector2(position.x, position.y+20), 0.5)
	tween2.tween_property(self, "modulate", Color(1,1,1,1), 0.5)

func destroy():
	var tween = get_tree().create_tween()
	tween.tween_property(self, "modulate", Color(1,1,1,0), 0.5)
	
	await get_tree().create_timer(0.5).timeout
	
	queue_free()
