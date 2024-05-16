extends GridContainer


@onready var itemPanelFill = preload("res://Global/Game_UI/Action_bar/Item_panel/item_panel_fill.tscn")
@onready var itemPanelEmpty = preload("res://Global/Game_UI/Action_bar/Item_panel/item_panel_empty.tscn")


func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func init_items(items):
	for item in items:
		pass
