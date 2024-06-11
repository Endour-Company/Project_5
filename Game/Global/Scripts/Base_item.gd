extends Node2D

# Called when the node enters the scene tree for the first time.
@export var ITEM_NAME : String = "" :
	set (value):
		ITEM_NAME = value
	get:
		return ITEM_NAME

var ITEM_LEVEL : int = 1
var ITEM_JSON : Dictionary = {}
var ITEM_TEXTURE : Texture2D = null

func _ready():
	GlobalItemsLevel.item_upgraded.connect(_on_item_upgraded)
	#var itemjson = Utils.find_item_in_array_with_key(GlobalItemsLevel.ITEMS_JSON, "name", ITEM_NAME)
	
	var itemJson = null

	
	for itemsPerArea in GlobalItemsLevel.ITEMS_PER_AREA :
		var itemsInArea = itemsPerArea["items"]
		
		
		itemJson = Utils.find_item_in_array_with_key(itemsInArea, "name", ITEM_NAME)
		if(itemJson != null):
			ITEM_JSON = itemJson
	
	init_item()
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func set_item_name(name: String):
	ITEM_NAME = name

func _process(delta):
	pass
	
	

func _on_item_upgraded(itemName):
	init_item()


func init_item():
	init_item_level_info()
	init_item_visual_info()
	
	# Set Item Image
	$CharacterBody2D/Sprite2D.set_texture(ITEM_TEXTURE)
	
func init_item_level_info():
	var item = Utils.find_item_in_array_with_key(GlobalItemsLevel.ITEM_LEVEL, "name", ITEM_NAME)
	ITEM_LEVEL = item["level"]
	

func init_item_visual_info():
	var itemlevelInfo = Utils.find_item_in_array_with_key(ITEM_JSON["levels"], "level", ITEM_LEVEL)
	var itemTexturePath = itemlevelInfo["img"]
	ITEM_TEXTURE = load(itemTexturePath)
	
	

