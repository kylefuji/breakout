extends Node2D

var twoPlayers:bool
var difficulty:int
var firstTo:int

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS 

func start() -> void:
	show()
	$PlayButton.grab_focus()
	$RestartButton.show()
	if Global.twoPlayers == null and \
	Global.difficulty == null and \
	Global.firstTo == null:
		$RestartButton.hide()

func _on_play_button_pressed() -> void:
	twoPlayers = $"2Players".button_pressed
	difficulty = $difficulty.get_selected()
	firstTo = $FirstTo.value
	
	if Global.twoPlayers != twoPlayers or \
	Global.difficulty != difficulty or \
	Global.firstTo != firstTo:
		return _reset()
	
	Global.toggleMenu()

func _on_restart_button_pressed() -> void:
	twoPlayers = $"2Players".button_pressed
	difficulty = $difficulty.get_selected()
	firstTo = $FirstTo.value
	_reset()
	
func _reset() -> void:
	if difficulty == 0:
		Global.ball.speed = 50
		Global.ball.bounceIncrease = 20
		if not twoPlayers:
			Global.paddle2.speed = 100
		else:
			Global.paddle2.speed = Global.paddle1.speed
	elif difficulty == 1:
		Global.ball.speed = 100
		Global.ball.bounceIncrease = 20
		if not twoPlayers:
			Global.paddle2.speed = 200
		else:
			Global.paddle2.speed = Global.paddle1.speed
	elif difficulty == 2:
		Global.ball.speed = 150
		Global.ball.bounceIncrease = 30
		if not twoPlayers:
			Global.paddle2.speed = 300
		else:
			Global.paddle2.speed = Global.paddle1.speed
	Global.is_startup = false
	Global.winLabel.hide()
	Global.twoPlayers = twoPlayers 
	Global.difficulty = difficulty 
	Global.firstTo = firstTo
	Global.gameScene.show()
	Global.is_paused = not Global.is_paused
	Global.toggle_pause()
	hide()
	Global.scoreArea1.reset()
	Global.scoreArea2.reset()
	Global.ball.reset()


func _on_quit_button_pressed() -> void:
	get_tree().quit()
