class_name PushableRigidBody extends RigidBody2D

var lives: int = 4
@export var extra_strength:int = 1
@export var start_disabled: bool = false

func pushed(dir:Vector2, strength:float):#origin:Vector2
	#vel = velocity = power * direction, origin = origin of blast
	freeze = false
	sleeping = false
	var impulse:Vector2 = Vector2(dir.x *strength * extra_strength, dir.y)
	if impulse.y<-300:
		impulse = Vector2(dir.x *strength * extra_strength, -300)
	apply_impulse(impulse)
	print(name +"impulse applied, "+str(impulse)+" frozen = "+ str(freeze))

func damaged(damage_array:Array[int]):
	pass

func destroy():
	pass
