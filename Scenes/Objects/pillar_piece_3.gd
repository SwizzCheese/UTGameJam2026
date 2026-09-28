extends PushableRigidBody


func _ready() -> void:
	body_entered.connect(_on_body_entered)

func pushed(dir:Vector2, strength:float):#origin:Vector2
	#vel = velocity = power * direction, origin = origin of blast
	freeze = false
	sleeping = false
	linear_velocity.y = 0
	var impulse:Vector2 = Vector2(dir.x *strength * extra_strength, 0.0)
	apply_impulse(impulse)
	print(name +"impulse applied, "+str(impulse)+" frozen = "+ str(freeze))


	apply_impulse(impulse)

	print(name, " velocity after impulse: ", linear_velocity)

func _physics_process(delta):
	#print(name, " velocity: ", linear_velocity)
	pass

func _on_body_entered(body):
	print(
		name,
		" COLLIDED WITH: ",
		body.name,
		" class=",
		body.get_class()
	)
