extends CharacterBody2D

@export var speed:int = 100
@export var bounceIncrease:int = 20
@export var countDown:Node2D

var target_velocity:Vector2 = Vector2.ZERO
var direction:Vector2 = Vector2(2,-1)
var bounceNoiseIter:int = 0
var initialPosition:Vector2 = Vector2.ZERO
var initial_speed:int = 0
var current_speed:int = speed
var savedDirection:Vector2 = direction

func _ready():
	initialPosition = position
	current_speed = speed
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	target_velocity.y = direction.y * current_speed
	target_velocity.x = direction.x * current_speed
	velocity = target_velocity
	
	var collision = move_and_collide(velocity * delta)
	
	if collision:
		var bounceNoise = get_node("BounceNoise" + str(bounceNoiseIter))
		bounceNoise.set_volume_db(-12)
		bounceNoise.play()
		bounceNoiseIter = 1 - bounceNoiseIter
		var normal = collision.get_normal()
		if normal == Vector2.UP or normal == Vector2.DOWN:
			direction.y *= -1
		if normal == Vector2.LEFT or normal == Vector2.RIGHT: 
			direction.x *= -1
			current_speed += bounceIncrease
			
func reset() -> void:
	position = initialPosition
	current_speed = speed
	bounceNoiseIter = 0
	Global.paddle1.reset()
	Global.paddle2.reset()
	countDown.start()
