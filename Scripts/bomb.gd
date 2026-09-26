class_name bomb
extends RigidBody2D

#either 1 or -1 to control direction of bomb's initial fling
@export var direction : int = 1
var initial_velocity : Vector2 = Vector2(300,-250)

signal thrown

func _ready() -> void:
	
	#thrown.emit
	var velocity : Vector2
	velocity.x = initial_velocity.x * direction
	velocity.y = initial_velocity.y
	apply_central_impulse(velocity)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	
	
	#if thrown:
		#var velocity : Vector2
		#velocity.x = initial_velocity.x * direction
		#velocity.y = initial_velocity.y
		#apply_impulse(velocity)
	
	pass
