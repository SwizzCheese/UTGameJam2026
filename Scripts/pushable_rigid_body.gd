class_name PushableRigidBody extends RigidBody2D

func pushed(dir:Vector2, strength:float):#origin:Vector2
	#vel = velocity = power * direction, origin = origin of blast
	apply_impulse(dir * strength)
	print("impulse applied, strength: "+str(strength))
