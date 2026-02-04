extends Node

var player1_score:int = 0
var player2_score:int = 0
var is_paused:bool = false
var is_timer:bool = false
var is_startup:bool = true
var menuScene:Node2D
var gameScene:Node2D
var countDown:Node2D
var scoreArea1:Area2D
var scoreArea2:Area2D
var menuOpenNoise:AudioStreamPlayer
var menuCloseNoise:AudioStreamPlayer
var ball:CharacterBody2D
var paddle1:CharacterBody2D
var paddle2:CharacterBody2D
var winLabel:RichTextLabel
var twoPlayers = null 
var difficulty = null
var firstTo = null
enum {
	CHECKBOX_ONE,
	CHECKBOX_TWO,
}

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	menuScene = get_tree().get_root().get_node("Pong/Menu")
	gameScene = get_tree().get_root().get_node("Pong/Game")
	ball = gameScene.get_node("Ball")
	menuOpenNoise = ball.get_node("BounceNoise1")
	menuCloseNoise = ball.get_node("BounceNoise0")
	scoreArea1 = gameScene.get_node("ScoreArea1")
	scoreArea2 = gameScene.get_node("ScoreArea2")
	paddle1 = gameScene.get_node("Paddle1")
	paddle2 = gameScene.get_node("Paddle2")
	winLabel = gameScene.get_node("WinLabel")
	menuOpenNoise.set_volume_db(-12)
	menuCloseNoise.set_volume_db(-12)
	toggle_pause()
	is_paused = true
	menuScene.start()
	
func resetBall():
	pass
	
func toggle_pause():
	# 'get_tree()' accesses the SceneTree singleton.
	# Setting 'paused' to true stops most game processes (like _process and _physics_process).
	get_tree().paused = not get_tree().paused 
	# You can emit a signal here to notify UI elements (like a pause menu) of the state change
	# emit_signal("game_paused", get_tree().paused)

func _input(_event: InputEvent) -> void:
	if Input.is_action_pressed("pause") and not is_timer and not is_startup:
		toggleMenu()

func toggleMenu() -> void:
	is_paused = not is_paused
	toggle_pause()
	if is_paused:
		menuOpenNoise.play()
		menuScene.start()
		gameScene.hide()
	else:
		menuCloseNoise.play()
		menuScene.hide()
		gameScene.show()
