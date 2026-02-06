extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS 
	Global.toggle_pause()
	start()
	

func start() -> void:
	$PlayButton.grab_focus()


func _on_play_button_pressed() -> void:
	Global.toggle_menu()


func _on_restart_button_pressed() -> void:
	Global.reset()
	Global.toggle_menu()


func _on_quit_button_pressed() -> void:
	get_tree().quit()
