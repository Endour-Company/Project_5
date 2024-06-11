extends "res://Game/Global/Scripts/Base_item.gd"

var SAWAH_POINTS = [
	{
		"id": "sawah1",
		"points": [
			{ "startX": 733, "startY": 237, "endX": 439, "endY": 237 },
			{ "startX": 422, "startY": 291, "endX": 701, "endY": 291 },
			{ "startX": 688, "startY": 355, "endX": 398, "endY": 355 }
		]
	},
	{
		"id": "sawah2",
		"points": [
			{ "startX": 1236, "startY": 222, "endX": 940, "endY": 222 },
			{ "startX": 907, "startY": 291, "endX": 1202, "endY": 291 },
			{ "startX": 1181, "startY": 351, "endX": 877, "endY": 351 }
		]
	},
	{
		"id": "sawah3",
		"points": [
			{ "startX": 1136, "startY": 472, "endX": 839, "endY": 472 },
			{ "startX": 815, "startY": 529, "endX": 1117, "endY": 529 },
			{ "startX": 1093, "startY": 610, "endX": 800, "endY": 605 }
		]
	},
	{
		"id": "sawah4",
		"points": [
			{ "startX": 645, "startY": 481, "endX": 329, "endY": 481 },
			{ "startX": 322, "startY": 531, "endX": 612, "endY": 531 },
			{ "startX": 598, "startY": 607, "endX": 291, "endY": 607 }
		]
	}
]

@export var TRACTOR_VELOCITY : float = 200
@export var SHAKE_AMPLITUDE : float = 0.5  # Amplitudo getaran (ke atas dan ke bawah)
@export var SHAKE_SPEED : float = 20      # Kecepatan getaran
@export var BRAKE_DECELERATION : float = 200  # Laju deselerasi saat pengereman


signal membajak_is_done

enum TRACTOR_STATES {
	IDLE,
	MOVE,
}

@export var TRACTOR_STATE = TRACTOR_STATES.MOVE
var TRACTOR_DONE = false
var shake_timer = 0.0
var current_velocity = TRACTOR_VELOCITY
var t = 0.0  # Parameter interpolasi

var current_sawah = 0
var current_point_index = 0
var start_point = Vector2()
var end_point = Vector2()

func _ready():
	ITEM_NAME = "Alat Pertanian"
	ITEM_TEXTURE_NODE = $CharacterBody2D/Sprite2D
	super._ready()
	set_points_for_current_sawah()

func _process(delta):
	match TRACTOR_STATE:
		TRACTOR_STATES.IDLE:
			idle_state()
		TRACTOR_STATES.MOVE:
			move_state(delta)

func behaviour_membajak():
	print("saatnya membajak")
	set_tractor_state_move()

func idle_state():
	$CharacterBody2D.global_position = Vector2(1397,77)
	t = 0.0  # Reset parameter interpolasi

func move_state(delta):
	if TRACTOR_DONE:
		apply_brake(delta)
	else:
		move_along_path(delta)
		apply_shake_effect(delta)
	
	$CharacterBody2D.move_and_slide()

func move_along_path(delta):
	t += delta * TRACTOR_VELOCITY / start_point.distance_to(end_point)
	if t >= 1.0:
		t = 0.0
		if current_point_index < SAWAH_POINTS[current_sawah]["points"].size() - 1:
			current_point_index += 1
		else:
			current_sawah += 1
			current_point_index = 0
			if current_sawah >= SAWAH_POINTS.size():
				current_sawah = 0  # Reset to the first sawah or set TRACTOR_DONE to true if you want to stop the tractor
				TRACTOR_DONE = true  # Uncomment if you want to stop the tractor when all sawahs are done
		set_points_for_current_sawah()
	$CharacterBody2D.global_position = start_point.lerp(end_point, t)
	handle_flip()

func apply_brake(delta):
	if current_velocity > 0:
		current_velocity -= BRAKE_DECELERATION * delta
		if current_velocity < 0:
			current_velocity = 0
	$CharacterBody2D.velocity = Vector2(current_velocity, 0)
	
	if current_velocity == 0:
		set_tractor_state_idle()
		emit_signal("membajak_is_done")

func apply_shake_effect(delta):
	shake_timer += delta * SHAKE_SPEED
	var shake_offset = sin(shake_timer) * SHAKE_AMPLITUDE
	$CharacterBody2D/Sprite2D.position.y += shake_offset

func set_points_for_current_sawah():
	var points = SAWAH_POINTS[current_sawah]["points"][current_point_index]
	start_point = Vector2(points["startX"], points["startY"])
	end_point = Vector2(points["endX"], points["endY"])

func set_tractor_state_idle():
	TRACTOR_STATE = TRACTOR_STATES.IDLE

func set_tractor_state_move():
	TRACTOR_STATE = TRACTOR_STATES.MOVE
	current_velocity = TRACTOR_VELOCITY
	TRACTOR_DONE = false
	t = 0.0  # Reset parameter interpolasi

func handle_flip():
	# Flip the tractor horizontally when moving to the second point
	var points = SAWAH_POINTS[current_sawah]["points"]
	if current_point_index == 1:
		$CharacterBody2D/Sprite2D.flip_h = true
	else:
		$CharacterBody2D/Sprite2D.flip_h = false
