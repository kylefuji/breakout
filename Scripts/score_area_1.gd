extends Area2D

@export var playerScore : RichTextLabel
@export var ball : CharacterBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Connect the signal in code (alternative to the editor)
	connect("body_entered", Callable(self, "_on_body_entered"))
	process_mode = Node.PROCESS_MODE_ALWAYS

func _on_body_entered(body: Node2D) -> void:
	if body == ball:
		var scoreNoise = get_node("Score")
		scoreNoise.set_volume_db(-12)
		scoreNoise.play()
		Global.player2_score += 1
		playerScore.text = str(Global.player2_score)
		if Global.player2_score >= Global.firstTo:
			Global.winLabel.text = "[center]Player 2 Wins![/center]"
			Global.winLabel.show()
			return
		ball.reset()

func reset() -> void:
	Global.player2_score = 0
	playerScore.text = str(Global.player2_score)
