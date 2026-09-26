class_name PushableRigidBody extends RigidBody2D

var lives: int = 4

func pushed(dir:Vector2, strength:float):#origin:Vector2
	#vel = velocity = power * direction, origin = origin of blast
	apply_impulse(dir * strength)
	print("impulse applied, strength: "+str(strength))

func damaged(damage_array:Array[int]):
	pass

func destroy():
	pass
