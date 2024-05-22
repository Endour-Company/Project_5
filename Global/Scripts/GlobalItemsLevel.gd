extends Node

var ITEM_LEVEL = [
	{
		"name" : "Traktor",
		"level" : 2,
		"count" : 1,
		
	},
	{
		"name" : "Jalan",
		"level" : 2,
		"count" : 1,

 	},
	{
		"name" : "Lampu Jalan",
		"level" : 1,
		"count" : 1
	}
]

enum CURRENT_PLACE {
	PLACE_ricefiled,
	PLACE_forest
}


func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func greeting():
	print("Hello world")
