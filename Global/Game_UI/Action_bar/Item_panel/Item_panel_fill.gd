extends Panel

@onready var SFX = $SFX
@onready var item = preload("res://Global/Game_UI/Action_bar/Item/Item.tscn")
func _ready():
	pass

func init_item_panel(itemPath : String, price : int, itemName : String):
	var myItem = item.instantiate()
	myItem.image = load(itemPath)
	myItem.price = price
	myItem.itemName = itemName
	add_child(myItem)
	

func _on_mouse_entered():
	# Play hover sfx
	SFX.set_volume_db(GameAudio.get_volume_sfx())
	GameAudio.play(SFX, GameAudio.SFX_Gameplay_Hover)
