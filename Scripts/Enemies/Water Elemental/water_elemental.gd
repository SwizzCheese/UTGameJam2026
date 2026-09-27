extends BaseEnemy
#This is the script for a basic enemy, like a goblin.

@onready var wall_detector = $RayCast2D
@onready var push_timer = $Timer
@onready var water_elemental = $AnimatedSprite2D
@onready var water_particles = $CPUParticles2D
@onready var is_dead: bool = false

@export var water_split : PackedScene
func _ready() -> void:
	speed = 100.0
	direction = 1.0
	health = 1
	acceleration = 0.1
	push_timer.timeout.connect(push_timer_timeout)
	being_pushed = false

func destroyed() -> void:
	_split_the_water()
	super.destroyed()

func _split_the_water() -> void:
	#Altering the range will determine how many children this enemy can spawn
	#I chose 2, but more is funny. Less is less funny
	for i in range(2):
		var child_spawn_point = water_split.instantiate()
		get_tree().current_scene.add_child(child_spawn_point)
		child_spawn_point.global_position = global_position
		print("Elemental spaned at", global_position)
		#After those explosion struggles, I'm just gonna do random trajectory
		var marker_direction := -1.0 if randf() < 0.5 else 1.0
		var marker_speed : float = 400
		var angle := randf_range(-60.0,-30.0)
		var marker_velocity := Vector2.from_angle(deg_to_rad(angle)) * marker_speed
		marker_velocity.x *= marker_direction
		child_spawn_point.launch(marker_velocity)
		print("launched at velocity" ,marker_velocity)

func _physics_process(delta: float) -> void:
	#checks if elemental is facing left or right
	if not is_on_floor():
		velocity += get_gravity() * delta
	if not being_pushed:
		velocity.x = lerp(velocity.x, direction * speed, acceleration)
	
	
	if wall_detector.is_colliding():
		change_direction()
		
		#This lets the elemental animation flip when it changes direction
		if(direction > 0):
			water_elemental.flip_h = true
		else:
			water_elemental.flip_h = false
		
		wall_detector.target_position.x = wall_detector.target_position.x * -1
	
	#This will cause destroyed() to only be caused once
	#I need this to let me do an on death trigger
	#Otherwise it would proc repeatedly
	if health <= 0 and not is_dead:
		is_dead = true
		destroyed()
	
	#Plays move animation and causes it to move
	water_elemental.play("Move")
	move_and_slide()

func _spawn_puddle() -> void:
	pass
	#water_elemental.play("Peeking")
	#water_particles.show()
	#await get_tree().create_timer(3.0).timeout
	#_spawn_babies()

func _spawn_babies() -> void:
	pass

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
