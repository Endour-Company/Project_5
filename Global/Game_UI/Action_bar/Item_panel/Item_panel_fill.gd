extends Panel


# Called when the node enters the scene tree for the first time.

@onready var item = preload("res://Global/Game_UI/Action_bar/Item/Item.tscn")
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	

func init_item_panel(itemPath : String, price : int):
	var myItem = item.instantiate()
	myItem.image = load(itemPath)
	myItem.price = price
	add_child(myItem)
	
