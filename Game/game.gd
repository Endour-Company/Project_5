extends Node

var sceneMap : Control
var sceneOption : Control
var sceneTutorial : Control
var sceneEndDialog : Control
var sceneScoreboard : Control
@onready var BGM = $BGM
@onready var SFX = $SFX
@onready var globalTimer = $GlobalTimer
@onready var progressTime = $In_game_map_calendar/VBoxContainer/Calendar/HBoxContainer/TextureProgressBar
@onready var calendarText = $In_game_map_calendar/VBoxContainer/Calendar/HBoxContainer/Label
var prevTime = 0
var currentTime = 0
var maxTime = 10
var currentMonth = 0
var currentYear = 0
var currentCalendar = ""


# Called when the node enters the scene tree for the first time.
func _ready():
	GlobalActionBar.current_area_changed.connect(_on_current_area_changed)
	init_area()
	
	# Set BGM and SFX volume
	BGM.set_volume_db(GameAudio.get_volume_bgm())
	SFX.set_volume_db(GameAudio.get_volume_sfx())
	
	# Play BGM
	#GameAudio.play(BGM, GameAudio.BGM_Gameplay)
	
	# set global timer and progress circle
	globalTimer.start(maxTime)
	progressTime.set_value_no_signal(currentTime)
	
	# get current year and month
	var currentDate = Time.get_datetime_dict_from_system()
	currentMonth = currentDate["month"]-1
	currentYear = currentDate["year"]
	currentCalendar = Utils.convert_month_to_text(currentMonth) + " " + str(currentYear)
	
	# Set initial calendar text
	calendarText.set_text(currentCalendar)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	currentTime = maxTime - globalTimer.get_time_left()
	progressTime.set_value_no_signal((currentTime / maxTime) * 100)
	
	if currentTime - prevTime > 30:
		# If a month has passed
		currentMonth = currentMonth+1
		if currentMonth == 12 :
			# Set to next year
			currentMonth = 0
			currentYear = currentYear + 1
			
		# Set new calendar text
		currentCalendar = Utils.convert_month_to_text(currentMonth) + " " + str(currentYear)
		calendarText.set_text(currentCalendar)
		
		prevTime = currentTime

func init_area():
	var areas = {
		GlobalActionBar.AREAS.SAWAH: $Ricefield_area,
		GlobalActionBar.AREAS.HUTAN: $Area_Hutan,
		GlobalActionBar.AREAS.PEMUKIMAN: $AreaPemukiman,
		GlobalActionBar.AREAS.PUSATDESA: $AreaPusat
	}
	
	for area in areas:
		areas[area].visible = (area == GlobalActionBar.CURRENT_AREA)

func _on_current_area_changed():
	init_area()

func _on_bgm_changed(value : float):
	GameAudio.set_volume_bgm(GameAudio.to_db(value))
	BGM.set_volume_db(GameAudio.get_volume_bgm())

func _on_sfx_changed(value : float):
	GameAudio.set_volume_sfx(GameAudio.to_db(value))
	SFX.set_volume_db(GameAudio.get_volume_sfx())

func _on_button_option_pressed():
	sceneOption = preload("res://Global/Game_UI/Option/Main/option.tscn").instantiate()
	sceneOption.connect("bgm_changed", _on_bgm_changed)
	sceneOption.connect("sfx_changed", _on_sfx_changed)
	sceneOption.close_signal.connect(_on_option_close)
	add_child(sceneOption)
	
func _on_option_close():
	sceneOption.queue_free()

func _on_map_texture_button_pressed():
	sceneMap = preload("res://Global/Game_UI/Map/Main/Map.tscn").instantiate()
	sceneMap.close_signal.connect(_on_map_close)
	sceneMap.area_hutan.connect(_on_area_hutan)
	sceneMap.area_sawah.connect(_on_area_sawah)
	sceneMap.area_pemukiman.connect(_on_area_pemukiman)
	sceneMap.area_pusatdesa.connect(_on_area_pusatdesa)
	add_child(sceneMap)


func _on_map_close():
	close_map()
	
	
func _on_area_hutan():
	GlobalActionBar.set_current_area(GlobalActionBar.AREAS.HUTAN)
	close_map()
	
func _on_area_sawah():
	GlobalActionBar.set_current_area(GlobalActionBar.AREAS.SAWAH)
	close_map()
	
func _on_area_pemukiman():
	GlobalActionBar.set_current_area(GlobalActionBar.AREAS.PEMUKIMAN)
	close_map()
	
func _on_area_pusatdesa():
	GlobalActionBar.set_current_area(GlobalActionBar.AREAS.PUSATDESA)
	close_map()
	
	
func close_map():
	sceneMap.queue_free()

func _on_global_timer_timeout():
	# Show end game dialog
	sceneEndDialog = preload("res://Global/Game_UI/EndGame_Dialog/Main/endgame_dialog.tscn").instantiate()
	sceneEndDialog.connect("view_scoreboard", _on_view_scoreboard)
	add_child(sceneEndDialog)
	
	# Stop BGM
	BGM.stop()

func _on_view_scoreboard():
	# Show scoreboard
	sceneScoreboard = preload("res://Global/Game_UI/EndGame_Scoreboard/Main/endgame_scoreboard.tscn").instantiate()
	add_child(sceneScoreboard)
