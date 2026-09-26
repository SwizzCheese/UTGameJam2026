class_name PushableBody extends CharacterBody2D


const SPEED = 300.0



func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		print("VECOCITY: "+ str(velocity))
	move_and_slide()

func pushed(dir:Vector2, strength:float):
	print("HI, CHARACTER BODY PUSHED")
	velocity += dir * strength
	print("VELOCITY CHANGED: "+ str(velocity))
