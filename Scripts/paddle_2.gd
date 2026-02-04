extends CharacterBody2D

@export var speed = 200

var target_velocity:Vector2 = Vector2.ZERO
var initial_position:Vector2

func _ready() -> void:
	initial_position = position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if position.x != initial_position.x:
		position = initial_position
	var direction = Vector2.ZERO
	if Global.twoPlayers:
		if Input.is_action_pressed("paddle_2_up"):
			direction.y -= 1
		elif Input.is_action_pressed("paddle_2_down"):
			direction.y += 1
	else:
		if Global.ball.position.y > position.y:
			direction.y += 1
		elif Global.ball.position.y < position.y:
			direction.y -= 1
	
	target_velocity.y = direction.y * speed
	velocity = target_velocity
	move_and_slide()

func reset() -> void:
	position = initial_position
