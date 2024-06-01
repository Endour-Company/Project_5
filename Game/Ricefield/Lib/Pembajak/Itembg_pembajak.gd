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


func _ready():
	ITEM_NAME = "Pembajak"
	super._ready()

func behaviour_membajak():
	print("saatnya membajak")
	$CharacterBody2D.global_position = Vector2(646,166)
