extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("spacebar"):
		close_death_screen()

func open_death_screen() -> void:
	get_tree().paused = true
	show()


func close_death_screen() -> void:
	hide()
	get_tree().paused = false


func respawn()-> void:
	pass

func quit_to_menu() -> void:
	pass
