extends CharacterBody2D

@export var speed:int = 200

var bounceIncrease:int = 5
var direction:Vector2 = Vector2(1,-1)
var bounceNoiseIter:int = 0
var initialPosition:Vector2 = Vector2.ZERO
var initialDirection:Vector2 = Vector2.ZERO
var current_speed:int = speed

func _ready():
	initialPosition = position
	initialDirection = direction
	current_speed = speed

func _process(delta: float) -> void:
	velocity = direction * current_speed
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
			
		var collider = collision.get_collider()
		
		if collider.is_in_group("GreenTile"):
			current_speed += bounceIncrease
			collider.get_parent().queue_free()
			if len(Global.tiles.get_children()) <= 1:
				Global.endGameLabel.text = "[center]You Win![/center]"
				current_speed = 0
			Global.add_score(10+current_speed/20)
			
		if collider.is_in_group("YellowTile"):
			tile_collide(collider, "YellowTile", "GreenTile", Color(0.0, 1.0, 0.0, 1.0))
			
		if collider.is_in_group("OrangeTile"):
			tile_collide(collider, "OrangeTile", "YellowTile", Color(0.953, 0.78, 0.0, 1.0))
			
		if collider.is_in_group("RedTile"):
			Global.paddle.hard_mode()
			tile_collide(collider, "RedTile", "OrangeTile", Color(1.0, 0.537, 0.0, 1.0))

func tile_collide(collider, old_group, new_group, color):
	current_speed += bounceIncrease
	collider.modulate = color
	collider.remove_from_group(old_group)
	collider.add_to_group(new_group)
	Global.add_score(10+current_speed/20)

func reset():
	position = initialPosition
	direction = initialDirection
	current_speed = speed
