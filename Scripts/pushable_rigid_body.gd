class_name PushableRigidBody extends RigidBody2D

func pushed(vel:Vector2, origin:Vector2):
	#vel = velocity = power * direction, origin = origin of blast
	apply_impulse(vel, origin)
