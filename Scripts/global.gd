extends Node

var player_score:int = 0
var high_score:int = 0
var is_paused:bool = false
var lives:int = 3

var menuScene:Node2D
var gameScene:Node2D

var menuOpenNoise:AudioStreamPlayer
var menuCloseNoise:AudioStreamPlayer
var ball:CharacterBody2D
var paddle:CharacterBody2D
var scoreText:RichTextLabel
var endGameLabel:RichTextLabel
var highScoreText:RichTextLabel
var tiles:Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	menuScene = get_tree().get_root().get_node("Main/Menu")
	gameScene = get_tree().get_root().get_node("Main/Game")
	ball = gameScene.get_node("Ball")
	paddle = gameScene.get_node("Paddle")
	menuOpenNoise = ball.get_node("BounceNoise1")
	menuOpenNoise.set_volume_db(-12)
	menuCloseNoise = ball.get_node("BounceNoise0")
	menuCloseNoise.set_volume_db(-12)
	scoreText = gameScene.get_node("Score")
	highScoreText = menuScene.get_node("HighScore")
	endGameLabel = gameScene.get_node("EndGameLabel")
	var score = load_from_file()
	if score:
		high_score = int(score)
		menuScene.get_node("HighScore").text = "[center]High Score: %d[/center]" % high_score
	
func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_cancel") or Input.is_action_pressed("pause") and not event.is_echo():
		toggle_menu()
	
func toggle_pause() -> void:
	is_paused = not is_paused
	get_tree().paused = not get_tree().paused 


func toggle_menu() -> void:
	toggle_pause()
	if is_paused:
		menuOpenNoise.play()
		menuScene.show()
		menuScene.start()
		gameScene.hide()
	else:
		menuCloseNoise.play()
		menuScene.hide()
		gameScene.show()

func add_score(score:int) -> void:
	if paddle.is_hard:
		player_score += 5
	player_score += score
	scoreText.text = str(player_score)
	if player_score > high_score:
		high_score = player_score
		highScoreText.text = "[center]High Score: %d[/center]" % high_score
		save_to_file(str(high_score))

func reset() -> void:
	ball.reset()
	paddle.reset()
	player_score = 0
	add_score(0)
	gameScene.reset()
	lives = 3
	for i in range(lives, 0, -1):
		print(i)
		gameScene.get_node("Heart%d" % i).show()

func save_to_file(content):
	var file = FileAccess.open("user://save_game.dat", FileAccess.WRITE)
	file.store_string(content)

func load_from_file():
	var file = FileAccess.open("user://save_game.dat", FileAccess.READ)
	if file:
		var content = file.get_as_text()
		return content
	return null
