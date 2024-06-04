extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func find_item_in_array_with_key(arr : Array,key:String,value):
	for item in arr:
		if(item[key] == value):
			return item
	return null

func parse_json_file_by_filepath(filePath : String):
	if FileAccess.file_exists(filePath):
		var dataFile = FileAccess.open(filePath, FileAccess.READ)
		var parsedResult = JSON.parse_string(dataFile.get_as_text())
		return parsedResult
	else:
		return null

func format_rupiah(amount: int) -> String:
	if amount < 1000:
		return "Rp. " + str(amount)
	elif amount < 1000000:
		return "Rp. " + str(amount / 1000) + "K"
	elif amount < 1000000000:
		return "Rp. " + str(amount / 1000000) + "M"
	else:
		return "Rp. " + str(amount / 1000000000) + "B"
