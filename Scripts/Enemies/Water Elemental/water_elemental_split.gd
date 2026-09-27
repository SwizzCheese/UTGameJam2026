extends CharacterBody2D

@export var puddle_scene: PackedScene

func launch(initial_velocity: Vector2) -> void:
	velocity = initial_velocity

func _physics_process(delta: float) -> void:
	velocity += get_gravity() * delta
	var collision := move_and_collide(velocity * delta)
	if collision:
		print("marker hit something normal: ", collision.get_normal())
		var normal := collision.get_normal()
		if abs(normal.y) > abs(normal.x):
			_land()
		else:
			velocity = velocity.bounce(normal)
	
	
func _land() -> void:
	if puddle_scene:
		var puddle = puddle_scene.instantiate()
		get_tree().current_scene.add_child(puddle)
		puddle.global_position = global_position
		queue_free()
