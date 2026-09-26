class_name PushableRigidBody extends RigidBody2D


func pushed(magnitude:Vector2, origin: Vector2): #origin:Vector2
	#vel = velocity = power * direction, origin = origin of blast
	print("HI, RIGID BODY PUSHED")
	apply_impulse(magnitude, origin)
