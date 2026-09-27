class_name Player
extends PushableCharBody

var in_cutscene : bool

var max_health : int = 3
var health : int = max_health

var speed : int
var jump_velocity : int
#The LOWER slipperiness is, the more slippery the movement
var slipperiness : int
var gravity : int

#ONLY ASSIGN AS "1" or "-1"
var last_direction : int = 1
const BOMB : PackedScene = preload("uid://ctha3hokhls8e")

var current_spell : int
var current_bomb:int
var chucking : bool
var hurting : bool
var coyote_time_active : bool
var coyote_cooldown : bool

var spell_list : Array

var unlocked_spell_list : Array

var ult_array:Array[int]#  = [1, 0, 3, 2, 0]#empty, has test value
var max_ult_power:int = 5 #maximum number of times to power an ult

@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var animation : AnimationPlayer = $AnimationPlayer
@onready var hitbox: Area2D = $hitbox
@onready var invincible_timer: Timer = $invincible_timer
@onready var chuck_animation_timer : Timer = $ChuckAnimationTimer
@onready var coyote_timer : Timer = $CoyoteTimer

func _ready() -> void:
	if BOMB == null:
		print("BOMB is null!!!!!")
	speed = 200
	jump_velocity = -300
	slipperiness = 20
	gravity = 20
	
	in_cutscene = false
	chucking = false
	hurting = false
	coyote_time_active = false
	coyote_cooldown = false
	
	invincible_timer.timeout.connect(invincible_timer_timeout)
	chuck_animation_timer.timeout.connect(chuck_animation_timer_timeout)
	coyote_timer.timeout.connect(coyote_timer_timeout)
	
	#Check global for unlocked spell list!!

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ultimate"):
		release_ultimate()

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		if !coyote_time_active and !coyote_cooldown:
			coyote_timer.start()
			coyote_time_active = true
	if is_on_floor():
		coyote_timer.stop()
		coyote_time_active = false
		coyote_cooldown = false
	
	# Handle jump.
	if Input.is_action_just_pressed("up") and (is_on_floor() or coyote_time_active) and !in_cutscene:
		velocity.y = jump_velocity
		audio_stream_player_2d.play()
		
	
	if Input.is_action_just_pressed("throw_bomb") and !in_cutscene:
		throw_bomb()
	
	if Input.is_action_just_pressed("spell") and !in_cutscene:
		cast_spell()
	
	#if Input.is_action_just_pressed("change_spell"):
	#	change_spell()
	
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction and !in_cutscene:
		velocity.x = move_toward(velocity.x, direction * speed, slipperiness)
	else:
		velocity.x = move_toward(velocity.x, 0, slipperiness)
	
	if Input.is_action_pressed("left"):
		$Sprite2D.flip_h  = true
		last_direction = -1
	if Input.is_action_pressed("right"):
		$Sprite2D.flip_h  = false
		last_direction = 1
	
	
	if hurting:
		animation.play("hurt")
	elif !is_on_floor() and !chucking:
		animation.play("jump")
	elif !is_on_floor() and chucking:
		animation.play("jump_shoot")
	elif direction and !chucking:
		animation.play("run")
	elif direction and chucking:
		animation.play("run_shoot")
	elif !direction and chucking:
		animation.play("idle_shoot")
	else:
		animation.play("idle")
	
	
	move_and_slide()



func cast_spell():
	#Check Current_Spell and cast it using the following statements
	if current_spell == 1:
		#Cast GravityShove, which moves objects like a bomb
		pass
	elif current_spell == 2:
		#Cast VampiricTouch, which is a short range attack that heals on hit
		pass
	elif current_spell == 3:
		#Cast LightningBurst, which is a moderate range sphere of damage around the player
		pass
	elif current_spell == 4:
		#Cast Wind, maybe makes the player faster and floatier
		pass
	elif current_spell == 5:
		#Cast SheerHeartAttack, just insta-kills enemy within line of sight
		pass
	
	

func change_spell(new_bomb:int):
	current_bomb = new_bomb


func throw_bomb():
	#Instantiate a bomb object at BombCreationPoint with velocity away and up from player's global position
	var bomb_direction : Vector2 = Vector2(Input.get_axis("left", "right"), 1)
	if Input.is_action_pressed("down"):
		last_direction = 0
		bomb_direction.y = 0
	$BombCreationPoint.position.x = last_direction * 10.0
	$BombCreationPoint.position.y = bomb_direction.y * 10
	
	
	chucking = true
	chuck_animation_timer.start()
	var bomb_instance = BOMB.instantiate()
	bomb_instance.direction = Vector2(last_direction, bomb_direction.y)
	print("players current spell is: "+ str(current_bomb))
	bomb_instance.give_type(current_bomb)
	#get_tree().get_first_node_in_group("EntityRoot").add_child(bomb_instance)
	get_tree().get_first_node_in_group("EntityRoot").add_entity(bomb_instance)
	bomb_instance.global_transform = $BombCreationPoint.global_transform
	
func pushed(dir:Vector2, strength:float):
	#print("HI, Wiizard PUSHED")
	velocity += (dir * strength*10)
	#print("Wiizard VELOCITY CHANGED: "+ str(velocity))

func damaged(damage_array:Array[int]):
	if !in_cutscene:
		
		hurting = true
		health = health - damage_array[0]
		if health <= 0:
			destroyed()
		else:
			Global.player_hurt.emit(health)
		$hitbox/hitbox_collision.set_deferred("disabled", true)
		invincible_timer.start()
	
	

func destroyed():
	Global.player_died.emit()
	print("player dies")

func invincible_timer_timeout():
	hurting = false
	$hitbox/hitbox_collision.set_deferred("disabled", false)

func chuck_animation_timer_timeout():
	chucking = false

func coyote_timer_timeout():
	coyote_time_active = false
	coyote_cooldown = true
#region Ultimate

func release_ultimate() -> void:
	if ult_array.size() >= 5:
		var ult_explosion_load = load("res://Scenes/ult_explosion.tscn")
		var ult_explosion_instance = ult_explosion_load.instantiate()
		add_child(ult_explosion_instance)
		ult_explosion_instance.give_ult_array(ult_array)
	pass 
	

func add_to_ultimate(type:int) -> void:
	if ult_array.size() < (max_ult_power -1):
		ult_array.append(type)
#endregion
