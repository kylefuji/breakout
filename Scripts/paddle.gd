extends CharacterBody2D


@export var speed:int = 500

var initial_position:Vector2
var is_hard:bool = false

func _ready() -> void:
	initial_position = position

func _process(_delta: float) -> void:
	
	var direction = Vector2.ZERO
	if Input.is_action_pressed("ui_left") or Input.is_action_pressed("move_left"):
		direction.x -= 1
	elif Input.is_action_pressed("ui_right") or Input.is_action_pressed("move_right"):
		direction.x += 1

	velocity = direction * speed
	move_and_slide()

func reset() -> void:
	is_hard = false
	$PaddleEasy.show()
	$CollisionShape2DEasy.set_deferred("disabled", false)
	$PaddleHard.hide()
	$CollisionShape2DHard.set_deferred("disabled", true)
	position = initial_position
	
func hard_mode() -> void:
	is_hard = true
	$PaddleEasy.hide()
	$CollisionShape2DEasy.set_deferred("disabled", true)
	$PaddleHard.show()
	$CollisionShape2DHard.set_deferred("disabled", false)
