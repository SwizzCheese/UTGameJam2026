extends PushableCharBody


const JUMP_VELOCITY = -400.0


func _ready() -> void:
	lives = 2
	$Area2D.body_entered.connect(apply_impulse_to_collisions)

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		print("VECOCITY: "+ str(velocity))
		print("HI")
	move_and_slide()

func pushed(dir:Vector2, strength:float):
	#print("HI, CHARACTER BODY PUSHED")
	velocity += (dir * strength)
	#print("VELOCITY CHANGED: "+ str(velocity))

func apply_impulse_to_collisions(body:Node2D):
	if (velocity.y+velocity.x) > 200 && body.is_in_group("PushableRigid"):
		body.apply_impulse(velocity)
		velocity = velocity-(velocity-Vector2(body.mass, body.mass))
	pass


func damaged(damage_array:Array[int]):
	pass

func destroy():
	pass
