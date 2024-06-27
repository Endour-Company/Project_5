extends Node

var sceneIndicatorDetail : Control
var sceneMap : Control
var sceneOption : Control
var sceneTutorial : Control
var sceneConfirmExit : Control
var sceneEndDialog : Control
var sceneScoreboard : Control
@onready var BGM = $BGM
@onready var SFX = $SFX
@onready var globalTimer = $GlobalTimer
@onready var progressTime = $In_game_map_calendar/VBoxContainer/Calendar/HBoxContainer/TextureProgressBar
@onready var calendarText = $In_game_map_calendar/VBoxContainer/Calendar/HBoxContainer/Label
var prevTime = 0
var currentTime = 0
var maxTime = 180
var currentMonth = 0
var currentYear = 0
var currentCalendar = ""
var showDetailMoney = false
var showDetailWelfare = false
var showDetailHealth = false

# Custom signals
signal exit_signal


# Called when the node enters the scene tree for the first time.
func _ready():
	GlobalActionBar.current_area_changed.connect(_on_current_area_changed)
	init_area()
	
	# Set BGM and SFX volume
	BGM.set_volume_db(GameAudio.get_volume_bgm())
	SFX.set_volume_db(GameAudio.get_volume_sfx())
	
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
	update_indicators()
	update_calendar()
	
func update_indicators():
	$Progress_variable/HBoxContainer/Progress_public_welfare.set_value_no_signal(Variables.VAR_KESEJAHTERAAN_MASYARAKAT * 100)
	$Progress_variable/HBoxContainer/Progress_public_health.set_value_no_signal(Variables.VAR_KESEHATAN_MASYARAKAT * 100)

func update_calendar():
	currentTime = maxTime - globalTimer.get_time_left()
	progressTime.set_value_no_signal((currentTime / maxTime) * 100)
	
	if currentTime - prevTime > 30:
		# If a month has passed
		currentMonth = currentMonth+1
		if currentMonth == 12 :
			# Set to next year
			currentMonth = 0
			currentYear = currentYear + 1
			
			# Tambah dana per tahun
			Variables.MONEY += 100000000
			
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
	# Play sfx
	GameAudio.play(SFX, GameAudio.SFX_MainMenu_Click)
	
	# Show option scene
	sceneOption = preload("res://Global/Game_UI/Option/Main/option.tscn").instantiate()
	sceneOption.bgm_changed.connect(_on_bgm_changed)
	sceneOption.sfx_changed.connect(_on_sfx_changed)
	sceneOption.close_signal.connect(_on_option_close)
	sceneOption.tutorial_signal.connect(_on_tutorial_signal)
	sceneOption.exit_signal.connect(_on_exit_signal)
	add_child(sceneOption)
	
func _on_option_close():
	# Play sfx
	GameAudio.play(SFX, GameAudio.SFX_Gameplay_Click)
	
	# Free sceneOption
	sceneOption.queue_free()
	
func _on_tutorial_signal():
	# Play sfx
	GameAudio.play(SFX, GameAudio.SFX_MainMenu_Click)
	
	# Show tutorial scene
	sceneTutorial = preload("res://Global/Game_UI/Tutorial/Main/tutorial_book.tscn").instantiate()
	sceneTutorial.close_signal.connect(_on_tutorial_close)
	add_child(sceneTutorial)
	
func _on_tutorial_close():
	# Play sfx
	GameAudio.play(SFX, GameAudio.SFX_MainMenu_Close)
	
	# Free tutorial scene
	sceneTutorial.queue_free()
	
func _on_exit_signal():
	# Play sfx
	GameAudio.play(SFX, GameAudio.SFX_MainMenu_Click)
	
	# Show confirmation screen
	sceneConfirmExit = preload("res://Global/Game_UI/Confirmation_Dialog/Main/confirmation_dialog.tscn").instantiate()
	sceneConfirmExit.confirmed.connect(_on_exit_confirmed)
	sceneConfirmExit.close_signal.connect(_on_confirm_close)
	add_child(sceneConfirmExit)
	
func _on_exit_confirmed():
	# Stop BGM
	BGM.stop()
	
	# Emit exit_signal
	exit_signal.emit()

func _on_confirm_close():
	# Free confirm scene
	sceneConfirmExit.queue_free()

func _on_map_texture_button_mouse_entered():
	GameAudio.play(SFX, GameAudio.SFX_Gameplay_Hover)


func _on_map_texture_button_pressed():
	GameAudio.play(SFX, GameAudio.SFX_Gameplay_Click)
	
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
	sceneScoreboard.connect("close_signal", _on_close_signal)
	add_child(sceneScoreboard)

func _on_close_signal():
	# Send signal to go back to main menu
	exit_signal.emit()

func _on_animation_player_animation_finished(anim_name):
	# Play BGM
	GameAudio.play(BGM, GameAudio.BGM_Gameplay)
	
	# Delete Overlay and AnimPlayer
	$Overlay.queue_free()
	$AnimationPlayer.queue_free()


func show_indicator_detail(indicator: String):
	if sceneIndicatorDetail != null:
		return
	sceneIndicatorDetail = preload("res://Global/Game_UI/Progress_variable/Lib/detail.tscn").instantiate()
	match indicator:
		"Dana Desa":
			sceneIndicatorDetail.title = "Dana Desa"
			sceneIndicatorDetail.desc = "Kamu dapat membeli atau meningkatkan fasilitas di berbagai sektor menggunakan dana desa ini. Kamu akan mendapatkan Rp100 juta per tahunnya dari negara."
			sceneIndicatorDetail.set_position(Vector2(487, 123))
		"Kesejahteraan":
			sceneIndicatorDetail.title = "Kesejahteraan Masyarakat"
			sceneIndicatorDetail.desc = "Kesejahteraan menunjukkan seberapa bahagia warga desa di bawah kepemimpinanmu. Tingkatkan fasilitas pelayanan dan hiburan untuk meningkatkan indikator ini."
			sceneIndicatorDetail.set_position(Vector2(824, 123))
		"Kesehatan":
			sceneIndicatorDetail.title = "Kesehatan Masyarakat"
			sceneIndicatorDetail.desc = "Kesehatan menunjukkan tingkat harapan hidup warga desa. Indikator ini memiliki kaitan kuat dengan kualitas lingkungan desa dan fasilitas kesehatan."
			sceneIndicatorDetail.set_position(Vector2(1158, 123))
	
	add_child(sceneIndicatorDetail)

func _on_indicator_mouse_exited():
	showDetailMoney = false
	showDetailWelfare = false
	showDetailHealth = false
	if sceneIndicatorDetail != null:
		sceneIndicatorDetail.destroy()

func _on_progress_money_mouse_entered():
	if showDetailMoney == true:
		return
	showDetailMoney = true
	await get_tree().create_timer(0.5).timeout
	if showDetailMoney == false:
		return
		
	show_indicator_detail("Dana Desa")

func _on_progress_public_welfare_mouse_entered():
	if showDetailWelfare == true:
		return
	showDetailWelfare = true
	await get_tree().create_timer(0.5).timeout
	if showDetailWelfare == false:
		return
		
	show_indicator_detail("Kesejahteraan")


func _on_progress_public_health_mouse_entered():
	if showDetailHealth == true:
		return
	showDetailHealth = true
	await get_tree().create_timer(0.5).timeout
	if showDetailHealth == false:
		return
		
	show_indicator_detail("Kesehatan")
