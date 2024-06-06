extends Node



var NODES_AREA = [
	{
		"area" : GlobalActionBar.AREAS.SAWAH,
		"node" : $Ricefield_area
	},
	{
		"area" : GlobalActionBar.AREAS.HUTAN,
		"node" : $Area_Hutan
	}
]

# Called when the node enters the scene tree for the first time.
func _ready():
	GlobalActionBar.current_area_changed.connect(_on_current_area_changed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _on_current_area_changed():
	for nodeArea in NODES_AREA :
		if(nodeArea["area"] != GlobalActionBar.CURRENT_AREA):
			var node = nodeArea["node"]
			node.set_visible(false)
	pass
