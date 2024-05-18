extends Node

var ITEM_LEVEL = [
	{
		"name" : "tractor",
		"level" : 2
	},
	{
		"name" : "street",
		"level" : 1
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
