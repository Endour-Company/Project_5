extends Node2D


# Called when the node enters the scene tree for the first time.

var image = load("")
var price = 0

@onready var itemImage = $VBoxContainer/Item_image
@onready var itemPrice = $VBoxContainer/Price
var it = load("res://Game/Ricefield/Assets/prototype/Jalan_lv1.png")
func _ready():
	itemImage.set_texture(image)
	itemPrice.set_text(str(price))
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func init_item(itemPath : String, price : int):
	print(itemPath)
	#itemImage.set_texture(itemPath)
	#itemPrice.set_text(price)
