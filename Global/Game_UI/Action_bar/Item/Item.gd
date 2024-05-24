extends Node2D


# Called when the node enters the scene tree for the first time.
var itemName = ""
var image = load("")
var price = 0

@onready var itemImage = $VBoxContainer/Item_image
@onready var itemPrice = $VBoxContainer/Price
var it = load("res://Game/Ricefield/Assets/prototype/Jalan_lv1.png")
func _ready():
	itemImage.set_texture(image)
	itemPrice.set_text(str(price))
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			print("Item clicked")
			change_current_selected_item(itemName)
	


func _on_mouse_entered():
	pass


func _on_mouse_exited():
	pass

func change_current_selected_item(selected_item_name : String):
	GlobalActionBar.set_selected_item(selected_item_name)
