extends Control

@onready var SFX = $SFX

var scoreboard : Control

signal close_signal

func _ready():
	# Set SFX initial volume
	SFX.set_volume_db(GameAudio.get_volume_sfx())
	
	# Read data from JSON
	var scoreData = Utils.parse_json_file_by_filepath("res://Data/score_data.json")
	
	# Generate score list from score data
	generate_list(scoreData)
	
func generate_list(data):
	var container = $Box/ScrollContainer/MarginContainer/ListSkor
	
	for score in data:
		# Get time
		var hour = str(score["date"]["hour"])
		var min = "0" + str(score["date"]["minute"])
		var day = str(score["date"]["day"])
		var month = "0" + str(score["date"]["month"])
		var year = str(score["date"]["year"])
		var datetime = hour + ":" + min.right(2) + " @ " + day + "/" + month.right(2) + "/" + year
		
		# Insert score data
		var scoreRow = preload("res://Global/Game_UI/History_Scoreboard/Lib/skor_box.tscn").instantiate()
		scoreRow.username = score["name"]
		scoreRow.time = datetime
		scoreRow.totalMoney = Utils.format_rupiah(score["money"])
		scoreRow.happiness = str(score["percentage_kesejahteraan"]) + "%"
		scoreRow.health = str(score["percentage_kesehatan"]) + "%"
		scoreRow.itemLevel = score["item_level"]
		
		# Connect signal
		scoreRow.see_detail.connect(_on_see_detail)
		
		# Add score row to container
		container.add_child(scoreRow)

func _on_see_detail(username, time, totalMoney, happiness, health, itemLevel):
	# Show scoreboard scene
	scoreboard = preload("res://Global/Game_UI/History_Scoreboard/Main/history_scoreboard.tscn").instantiate()
	scoreboard.username = username
	scoreboard.time = time
	scoreboard.totalMoney = totalMoney
	scoreboard.happiness = happiness
	scoreboard.health = health
	scoreboard.itemLevel = itemLevel
	scoreboard.close_signal.connect(_on_scoreboard_close)
	add_child(scoreboard)

func _on_scoreboard_close():
	# Play close SFX
	GameAudio.play(SFX, GameAudio.SFX_MainMenu_Close)
	
	# Delete scoreboard scene
	scoreboard.queue_free()

func _on_close_button_pressed():
	close_signal.emit()
