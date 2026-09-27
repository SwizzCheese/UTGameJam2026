class_name Bomb
extends RigidBody2D

#either 1 or -1 to control direction of bomb's initial fling
@export var direction : Vector2 = Vector2(1,0)
@export var time:float = 3

var type:int = 1 #1 for fire, 2 for water, 3 - earth, 4 - air
var initial_velocity : Vector2 = Vector2(300,-250)
var base_damage:int = 1

signal thrown
signal exploded(int, Vector2) #type, global_pos

@onready var explode_timer: Timer = $explode_timer

func _ready() -> void:
	
	explode_timer.timeout.connect(explode)
	var velocity : Vector2
	velocity.x = initial_velocity.x * direction.x
	velocity.y = initial_velocity.y * direction.y
	apply_central_impulse(velocity)
	
	explode_timer.start()




func explode() -> void:
	#explode
	print("bomb exploded, type: "+ str(type))
	exploded.emit(type, global_position)
	queue_free()

func give_type(spell_type:int):
	type = spell_type
