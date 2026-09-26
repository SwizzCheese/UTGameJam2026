class_name Bomb
extends RigidBody2D

#either 1 or -1 to control direction of bomb's initial fling
@export var direction : int = 1
@export var time:float = 3

var type:int = 0 #1 for fire, 2 for water, 3 - earth, 4 - air
var initial_velocity : Vector2 = Vector2(300,-250)
var base_damage:int = 1

signal thrown
signal exploded(int, Vector2) #type, global_pos

@onready var explode_timer: Timer = $explode_timer

func _ready() -> void:
	
	explode_timer.timeout.connect(explode)
	#thrown.emit
	var velocity : Vector2
	velocity.x = initial_velocity.x * direction
	velocity.y = initial_velocity.y
	apply_central_impulse(velocity)
	
	explode_timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	#if thrown:
		#var velocity : Vector2
		#velocity.x = initial_velocity.x * direction
		#velocity.y = initial_velocity.y
		#apply_impulse(velocity)
	pass

func explode() -> void:
	#explode
	#print("bomb exploded")
	exploded.emit(1, global_position)
	queue_free()
