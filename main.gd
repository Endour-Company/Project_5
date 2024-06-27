extends Node

'''
THIS IS THE MAIN NODE WHICH WILL BE EXECUTED WHEN THE GAME LAUNCHES
'''

# Scenes
var sceneMainMenu : Control
var sceneGame : Node
var sceneProlog : Control


func _ready():
	# Show main menu
	show_main_menu()
	
func show_main_menu():
	sceneMainMenu = preload("res://Main_menu/Main/main_menu.tscn").instantiate()
	sceneMainMenu.connect("start_signal", new_game)
	sceneMainMenu.connect("exit_signal", exit_game)
	add_child(sceneMainMenu)
	
func exit_game():
	get_tree().quit()

func new_game():
	# Show prolog
	Variables.reset_variables()
	GlobalItemsLevel.reset_item_level()
	show_prolog()
	
	# Delete main menu
	sceneMainMenu.queue_free()

func show_prolog():
	sceneProlog = preload("res://Prolog/Main/prolog.tscn").instantiate()
	sceneProlog.connect("prolog_done", show_game)
	add_child(sceneProlog)
	

func show_game():
	# Set initial area
	GlobalActionBar.CURRENT_AREA = GlobalActionBar.AREAS.PUSATDESA
	
	# Add game scene
	sceneGame = preload("res://Game/game.tscn").instantiate()
	sceneGame.connect("exit_signal", back_to_main_menu)
	add_child(sceneGame)
	
	# Delete prolog scene
	sceneProlog.queue_free()
	
func back_to_main_menu():
	# Show main menu scene
	show_main_menu()
	
	# Delete game scene
	sceneGame.queue_free()
