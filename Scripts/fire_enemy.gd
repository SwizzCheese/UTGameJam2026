extends BaseEnemy
#This is the script for a smarter, projectile throwing enemy, like a fireball.

@onready var wall_detector = $WallDetector
@onready var edge_detector = $EdgeDetector
@onready var push_timer = $PushTimer
@onready var attack_cooldown_timer = $AttackCooldown
@onready var sprite = $AnimatedSprite2D
@onready var attack_hitbox = $AttackHitbox
@onready var attack_particles = $GPUParticles2D
var attacking : bool

func _ready() -> void:
	speed = 50.0
	direction = 1.0
	health = 1
	acceleration = 0.1
	push_timer.timeout.connect(push_timer_timeout)
	attack_cooldown_timer.timeout.connect(attack)
	being_pushed = false
	attacking = false
	attack_cooldown_timer.start()
	attack_particles.emitting = false
	attack_hitbox.monitoring = false


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	if not being_pushed and not attacking:
		velocity.x = lerp(velocity.x, direction * speed, acceleration)
	else:
		velocity.x = 0.0
	
	if direction == -1:
		sprite.flip_h = false
		attack_particles.rotation_degrees = 180
	else:
		sprite.flip_h = true
		attack_particles.rotation_degrees = 0
	
	
	
	if wall_detector.is_colliding() and !attacking:
		change_direction()
		wall_detector.target_position.x = wall_detector.target_position.x * -1
		edge_detector.target_position.x = edge_detector.target_position.x * -1
		attack_hitbox.position.x = attack_hitbox.position.x * -1
	elif !edge_detector.is_colliding() and !attacking:
		change_direction()
		wall_detector.target_position.x = wall_detector.target_position.x * -1
		edge_detector.target_position.x = edge_detector.target_position.x * -1
		attack_hitbox.position.x = attack_hitbox.position.x * -1
	if health <= 0:
		sprite.visible = false
		$deathparticles.emitting = true
		await get_tree().create_timer(0.6).timeout
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

func attack():
	attacking = true
	sprite.play("fire")
	await get_tree().create_timer(1).timeout
	attack_particles.emitting = true
	attack_hitbox.monitoring = true
	await get_tree().create_timer(2).timeout
	attacking = false
	attack_particles.emitting = false
	attack_hitbox.monitoring = false
	attack_cooldown_timer.start()
	sprite.play("default")

func _on_attack_hitbox_area_entered(area: Area2D) -> void:
	var ray = RayCast2D.new()
	add_child(ray)
	#Detect if the explosion is through a wall
	ray.target_position = area.global_position - global_position
	ray.force_raycast_update()
	if not ray.is_colliding():
		if area.is_in_group("player"):
			var damage_array : Array[int] = [1,0,0,0,0]
			area.damaged(damage_array)
	
	

func pushed(dir : Vector2, strength : float):
	velocity += (dir * strength)
	push_timer.start()
	being_pushed = true
	

func push_timer_timeout():
	being_pushed = false
	print("PUSH END")
