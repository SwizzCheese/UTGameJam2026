class_name PushableCharBody extends CharacterBody2D

#6767
const SPEED = 300.0

func _ready() -> void:
	$Area2D.body_entered.connect(apply_impulse_to_collisions)

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		print("VECOCITY: "+ str(velocity))
		print("HI")
	move_and_slide()

func pushed(dir:Vector2, strength:float):
	print("HI, CHARACTER BODY PUSHED")
	velocity += (dir * strength)
	print("VELOCITY CHANGED: "+ str(velocity))

func apply_impulse_to_collisions(body:Node2D):
	if (velocity.y+velocity.x) > 200 && body.is_in_group("PushableRigid"):
		body.apply_impulse(velocity)
		velocity = velocity-(velocity-Vector2(body.mass, body.mass))
	pass
