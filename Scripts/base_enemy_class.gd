extends CharacterBody2D
class_name BaseEnemy

var speed : float
var direction : float
var acceleration : float
var being_pushed : bool
var health : int
var weakness : int
var resistance : int


func change_direction():
	if direction == 1:
		direction = -1
	elif direction == -1:
		direction = 1


func pushed(dir:Vector2, strength:float):
	pass


func damaged(damage_array:Array[int]):
	for i in damage_array:
		if i == 1:
			health -= 1
	


func destroyed():
	queue_free()
