extends "res://Game/Global/Scripts/Base_sungai.gd"

var trashScene = preload("res://Game/Global/Lib/Trash/trash.tscn")

func _ready():
	TEXTURE_NODE = $TextureRect
	textureSungaiKotor  = load("res://Game/Area_pemukiman/Assets/item_bg_sungai/sungai_kotor.png")
	textureSungaiNormal = load("res://Game/Area_pemukiman/Assets/item_bg_sungai/sungai_bersih.png")
	textureSungaiBerkilau = load("res://Game/Area_pemukiman/Assets/item_bg_sungai/sungai_berkilau.png")
	
	spawn_trash()
	super._ready()

func spawn_trash():
	var timer = Timer.new()
	timer.set_wait_time(5)
	timer.set_autostart(true)
		
	add_child(timer)
		
	var on_timeout = func _on_timeout():
		if STATUS_SUNGAI == STATUSES_SUNGAI.KOTOR :
			var trashNode = trashScene.instantiate()
			trashNode.TRASH_SCALE = 0.2
			$Trashes.add_child(trashNode)
			
		
	timer.connect("timeout", on_timeout)
