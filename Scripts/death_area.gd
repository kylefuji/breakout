extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_body_entered(body: Node2D) -> void:
	if body == Global.ball:
		Global.gameScene.get_node("Heart%d" % Global.lives).hide()
		Global.lives -= 1
		Global.ball.reset()
		if Global.lives == 0:
			Global.ball.current_speed = 0
			Global.endGameLabel.text = "[center]Game Over[/center]"
		
