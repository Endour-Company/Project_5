extends "res://Game/Global/Scripts/Base_sungai.gd"


# Called when the node enters the scene tree for the first time.
func _ready():
	TEXTURE_NODE = $TextureRect
	textureSungaiKotor  = load("res://Game/Ricefield/Assets/item_bg_sungai/sungai_kotor.png")
	textureSungaiNormal = load("res://Game/Ricefield/Assets/item_bg_sungai/sungai_bersih.png")
	textureSungaiBerkilau = load("res://Game/Ricefield/Assets/item_bg_sungai/sungai_berkilau.png")
	
	super._ready()

