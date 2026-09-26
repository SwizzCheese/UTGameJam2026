extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("spacebar"):
		close_pause_screen()

func open_pause_screen() -> void:
	get_tree().paused = true
	show()


func close_pause_screen() -> void:
	hide()
	get_tree().paused = false
