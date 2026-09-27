extends Control



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$respawn_button.pressed.connect(respawn)
	$quit_button.pressed.connect(quit_to_menu)
	print("Respawn disabled: ", $respawn_button.disabled)
	print("Quit disabled: ", $quit_button.disabled)
	hide()

func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		print("PARENT RECEIVED MOUSE")

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("spacebar"):
		close_death_screen()

func open_death_screen() -> void:
	print("I am here in death screen")
	show()


func close_death_screen() -> void:
	hide()
	get_tree().paused = false


func respawn()-> void:
	print("button pressed")
	Global.root._init_player()
	Global.root.load_level(1)
	hide()
	get_tree().paused = false
	
	

func quit_to_menu() -> void:
	Global.return_to_menu.emit()
	hide()
	
