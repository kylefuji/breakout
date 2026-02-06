extends CharacterBody2D


@export var speed:int = 200

func _process(delta: float) -> void:
	var direction = Vector2.ZERO
	direction.y -= 1
	velocity = direction * speed
	move_and_slide()
