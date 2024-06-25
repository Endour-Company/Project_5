extends Control

signal close_signal

func _ready():
	# Read data from JSON
	var scoreData = Utils.parse_json_file_by_filepath("res://Data/score_data.json")
	
	# Generate score list from score data
	generate_list(scoreData)
	
func generate_list(data):
	var container = $Box/ScrollContainer/MarginContainer/ListSkor
	
	for score in data:
		# Insert score data
		var scoreRow = preload("res://Global/Game_UI/History_Scoreboard/Lib/skor_box.tscn").instantiate()
		scoreRow.username = score["name"]
		scoreRow.totalMoney = Utils.format_rupiah(score["money"])
		scoreRow.happiness = str(score["percentage_kesejahteraan"]) + "%"
		scoreRow.health = str(score["percentage_kesehatan"]) + "%"
		
		# Add score row to container
		container.add_child(scoreRow)


func _on_close_button_pressed():
	close_signal.emit()
