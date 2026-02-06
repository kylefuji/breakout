extends Node

var player_score:int = 0
var is_paused:bool = false

var menuScene:Node2D
var gameScene:Node2D

var menuOpenNoise:AudioStreamPlayer
var menuCloseNoise:AudioStreamPlayer
var ball:CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	menuScene = get_tree().get_root().get_node("Main/Menu")
	gameScene = get_tree().get_root().get_node("Main/Game")
	ball = gameScene.get_node("Ball")
	
func toggle_pause() -> void:
	is_paused = not is_paused
	get_tree().paused = not get_tree().paused 


func toggle_menu() -> void:
	toggle_pause()
	if is_paused:
		#menuOpenNoise.play()
		menuScene.start()
		gameScene.hide()
	else:
		#menuCloseNoise.play()
		menuScene.hide()
		gameScene.show()
