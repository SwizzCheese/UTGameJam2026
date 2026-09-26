class_name Player
extends CharacterBody2D

var health : int
var max_health : int

var speed : int
var jump_velocity : int
#The LOWER slipperiness is, the more slippery the movement
var slipperiness : int
var gravity : int

#ONLY ASSIGN AS "1" or "-1"
var last_direction : int = 1
const BOMB : PackedScene = preload("uid://ctha3hokhls8e")

var current_spell : int

var spell_list : Array

var unlocked_spell_list : Array


func _ready() -> void:
	if BOMB == null:
		print("BOMB is null!!!!!")
	speed = 200
	jump_velocity = -300
	slipperiness = 20
	gravity = 20
	
	#Check global for unlocked spell list!!
	



func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	# Handle jump.
	if Input.is_action_just_pressed("up") and is_on_floor():
		velocity.y = jump_velocity
	
	if Input.is_action_just_pressed("throw_bomb"):
		throw_bomb()
	
	if Input.is_action_just_pressed("spell"):
		cast_spell()
	
	if Input.is_action_just_pressed("change_spell"):
		change_spell()
	
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, slipperiness)
	if Input.is_action_just_pressed("left"):
		last_direction = -1
		$BombCreationPoint.position = Vector2(-16.0,0)
	if Input.is_action_just_pressed("right"):
		last_direction = 1
		$BombCreationPoint.position = Vector2(16.0,0)
	
	move_and_slide()
	



func cast_spell():
	#Check Current_Spell and cast it using the following statements
	if current_spell == 1:
		#Cast GravityShove, which moves objects?
		pass
	elif current_spell == 2:
		#Cast LightningBolt, Hits enemy in line of sight then hits the closest enemy in a few tiles
		pass
	elif current_spell == 3:
		#Cast something idk bro
		pass
	elif current_spell == 4:
		#Cast Wind, maybe makes the player faster and floatier?
		pass
	elif current_spell == 5:
		#Cast SheerHeartAttack, just insta-kills enemy within line of sight
		pass
	
	

func change_spell():
	#Cycle through the unlocked spell list by one.
	pass


func throw_bomb():
	#Instantiate a bomb object at BombCreationPoint with velocity away and up from player's global position
	var bomb_instance = BOMB.instantiate()
	bomb_instance.direction = last_direction
	#get_tree().get_first_node_in_group("EntityRoot").add_child(bomb_instance)
	get_tree().get_first_node_in_group("EntityRoot").add_entity(bomb_instance)
	bomb_instance.global_transform = $BombCreationPoint.global_transform
	
