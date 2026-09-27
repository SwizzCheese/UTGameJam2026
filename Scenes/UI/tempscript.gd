extends Button


func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		print("Button received mouse event")
