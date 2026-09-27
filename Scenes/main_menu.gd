extends Control

@onready var control: Control = $CanvasLayer/Control
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_tree().paused = true
	$CanvasLayer/Control/Button.pressed.connect(_on_button_pressed)
	$CanvasLayer/Control/Button3	.pressed.connect(_on_button_2_pressed)
	$CanvasLayer/Control/Button2.pressed.connect(_on_quiz_pressed)
	Global.return_to_menu.connect(open_main_menu)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	

func open_main_menu() -> void:
	get_tree().paused = true
	$CanvasLayer/Sprite2D.visible = true
	show()
	control.show()


func _on_button_pressed() -> void:
	get_tree().paused = false
	$CanvasLayer/Sprite2D.visible = false
	hide()
	control.hide()


func _on_button_2_pressed() -> void:
	#get_tree().change_scene_to_file("")
	pass # Replace with function body.
	


func _on_quiz_pressed() -> void:
	get_tree().quit()
	pass # Replace with function body.
