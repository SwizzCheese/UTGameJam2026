extends Control

@onready var button: Button = $Button

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	button.pressed.connect(button_pressed)
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

func button_pressed() -> void:
	print("hi")
	close_pause_screen()
