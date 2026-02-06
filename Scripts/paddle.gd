extends CharacterBody2D


@export var speed:int = 500

var initial_position:Vector2

func _ready() -> void:
	initial_position = position

func _process(delta: float) -> void:
	
	var direction = Vector2.ZERO
	if Input.is_action_pressed("ui_left") or Input.is_action_pressed("move_left"):
		direction.x -= 1
	elif Input.is_action_pressed("ui_right") or Input.is_action_pressed("move_right"):
		direction.x += 1

	velocity = direction * speed
	move_and_slide()
