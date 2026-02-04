extends Node2D

@onready var time_display: RichTextLabel = $CenterContainer/Countdown
var total_seconds:int = 3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	
func start() -> void:
	total_seconds = 3
	time_display.text = str(total_seconds)
	$Timer.start()
	time_display.show()
	Global.toggle_pause()
	Global.is_timer = true

func _on_timer_timeout() -> void:
	total_seconds -= 1
	time_display.text = str(total_seconds)
	if total_seconds <= 0:
		$Timer.stop()
		Global.toggle_pause()
		time_display.hide()
		Global.is_timer = false
