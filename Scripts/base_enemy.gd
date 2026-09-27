extends BaseEnemy
#This is the script for a basic enemy, like a goblin.
@onready var wall_detector = $WallDetector
@onready var push_timer = $PushTimer

func _ready() -> void:
	speed = 100.0
	direction = 1.0
	health = 1
	acceleration = 0.1
	push_timer.timeout.connect(push_timer_timeout)
	being_pushed = false


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	if not being_pushed:
		velocity.x = lerp(velocity.x, direction * speed, acceleration)
	
	if wall_detector.is_colliding():
		change_direction()
		wall_detector.target_position.x = wall_detector.target_position.x * -1
	
	if health <= 0:
		destroyed()
	move_and_slide()


func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		var damage_array : Array[int] = [1,0,0,0,0]
		area.damaged(damage_array)
	elif area.is_in_group("explosion"):
		var ray = RayCast2D.new()
		add_child(ray)
		#Detect if the explosion is through a wall
		ray.target_position = area.global_position - global_position
		ray.force_raycast_update()
		if not ray.is_colliding():
			
			being_pushed = true
			push_timer.start()
			var damage_array : Array[int] = [1,0,0,0,0]
			damaged(damage_array)
	elif area.is_in_group("pusher"):
		pass
	elif area.is_in_group("lightning_burst"):
		pass
	elif area.is_in_group("vampiric_touch"):
		pass
	elif area.is_in_group("sheer_heart_attack"):
		pass
	

func pushed(dir : Vector2, strength : float):
	velocity += (dir * strength)
	push_timer.start()
	being_pushed = true
	

func push_timer_timeout():
	being_pushed = false
	print("PUSH END")
