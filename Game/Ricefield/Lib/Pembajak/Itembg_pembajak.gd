extends "res://Game/Global/Scripts/Base_item.gd"

var SAWAH_POINTS = [
		{
			"id": "sawah1",
			"points": [
				{ "startX": 646, "startY": 166, "endX": 377, "endY": 166 },
				{ "startX": 345, "startY": 216, "endX": 609, "endY": 216 },
				{ "startX": 595, "startY": 274, "endX": 332, "endY": 274 }
			]
		},
		{
			"id": "sawah2",
			"points": [
				{ "startX": 1110, "startY": 166, "endX": 819, "endY": 166 },
				{ "startX": 819, "startY": 211, "endX": 1000, "endY": 211 },
				{ "startX": 1062, "startY": 276, "endX": 787, "endY": 274 }
			]
		},
		{
			"id": "sawah3",
			"points": [
				{ "startX": 536, "startY": 415, "endX": 258, "endY": 413 },
				{ "startX": 507, "startY": 466, "endX": 244, "endY": 446 },
				{ "startX": 229, "startY": 514, "endX": 490, "endY": 514 }
			]
		},
		{
			"id": "sawah4",
			"points": [
				{ "startX": 1000, "startY": 404, "endX": 724, "endY": 404 },
				{ "startX": 707, "startY": 455, "endX": 983, "endY": 455 },
				{ "startX": 957, "startY": 516, "endX": 688, "endY": 516 }
			]
		}
	]

func _ready():
	ITEM_NAME = "Pembajak"
	behaviour_membajak()
	super._ready()

func behaviour_membajak():
	print(global_position)
