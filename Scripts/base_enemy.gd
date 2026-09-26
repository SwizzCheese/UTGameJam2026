extends PushableCharBody


var speed = 200
var direction = 1


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	velocity.x = direction * speed
	
	move_and_slide()

func change_direction():
	if direction == 1:
		direction = -1
	elif direction == -1:
		direction = 1
	
