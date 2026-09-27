extends AnimatedSprite2D

#This is for the sprite animations of the water elemental

#instance of the spritesheet
@onready var _animated_sprite = $AnimatedSprite2D

func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("ui_right"):
		_animated_sprite.play("run")
	else:
		_animated_sprite.stop()
