extends BaseLevel

#@onready var camera_2d: Camera2D = $Camera2D
@onready var marker_2d: Marker2D = $PlayerSpawn
@onready var countdown_timer : Timer = $CountdownTimer
@onready var exit : Node2D = $Exit
@onready var rubble1 : GPUParticles2D = $RubbleParticle
@onready var rubble2 : GPUParticles2D = $RubbleParticle2
@onready var explosion_reference = preload("uid://ttha2jxbh3it")
@onready var countdown_sprite : Sprite2D = $CountdownSprite
@export var level_num : int
var in_countdown : bool
var in_collapse_cutscene : bool

signal confirm

func _ready() -> void:
	countdown_timer.timeout.connect(countdown_failed)
	i_won = false
	in_collapse_cutscene = false
	in_countdown = false
	Global.give_HUD_time.emit(countdown_timer.wait_time)
	countdown_sprite.visible = false

func _input(event: InputEvent) -> void:
	if event.is_action("throw_bomb"):
		confirm.emit()

## Provides the player spawn point:
func get_default_player_spawn() -> Vector2:
	return marker_2d.global_position

## Provides the camera used in the level:
#func get_player_camera() -> Camera2D:
	#return camera_2d

func _process(_delta: float) -> void:
	
	if in_countdown:
		Global.root.camera.offset.x = randf_range(-3,3)
	elif in_collapse_cutscene:
		Global.root.camera.offset.x = randf_range(-10,10)
		
	else:
		Global.root.camera.offset.x = 0

func pillar_destroyed():
	pillars -= 1
	
	if pillars <= 0:
		start_countdown()


func start_countdown():
	countdown_timer.start()
	exit.open_exit()
	in_countdown = true
	countdown_sprite.visible = true
	while in_countdown:
		await get_tree().create_timer(1).timeout
		countdown_sprite.frame += 1

func countdown_failed():
	if !i_won and Global.player != null:
		Global.player.destroyed()
	countdown_sprite.visible = false
	countdown_timer.stop()
	in_countdown = false

func level_cleared():
	Global.level_won.emit()
	countdown_sprite.visible = false
	i_won = true
	countdown_timer.stop()
	Global.player.visible = false
	Global.player.in_cutscene = true
	#play the exploding floor animation
	in_countdown = false
	in_collapse_cutscene = true
	rubble1.emitting = true
	rubble2.emitting = true
	await get_tree().create_timer(0.2).timeout
	#generate explosion effect, repeat five times then big explosion
	var new_explosion = explosion_reference.instantiate()
	add_child(new_explosion)
	new_explosion.global_position.x = randf_range(25, 250)
	new_explosion.global_position.y += randf_range(-150,150)
	new_explosion.emitting = true
	
	await get_tree().create_timer(0.2).timeout
	#generate explosion effect, repeat five times then big explosion
	var new_explosion_2 = explosion_reference.instantiate()
	add_child(new_explosion_2)
	new_explosion_2.global_position.x = randf_range(25, 250)
	new_explosion_2.global_position.y += randf_range(-150,150)
	new_explosion_2.emitting = true
	
	await get_tree().create_timer(0.2).timeout
	#generate explosion effect, repeat five times then big explosion
	var new_explosion_3 = explosion_reference.instantiate()
	add_child(new_explosion_3)
	new_explosion_3.global_position.x = randf_range(25, 250)
	new_explosion_3.global_position.y += randf_range(-150,150)
	new_explosion_3.emitting = true
	
	await get_tree().create_timer(0.2).timeout
	#generate explosion effect, repeat five times then big explosion
	var new_explosion_5 = explosion_reference.instantiate()
	add_child(new_explosion_5)
	new_explosion_5.global_position.x = randf_range(25, 250)
	new_explosion_5.global_position.y += randf_range(-150,150)
	new_explosion_5.emitting = true
	
	await get_tree().create_timer(0.2).timeout
	#generate explosion effect, repeat five times then big explosion
	var new_explosion_6 = explosion_reference.instantiate()
	add_child(new_explosion_6)
	new_explosion_6.global_position.x = randf_range(25, 250)
	new_explosion_6.global_position.y += randf_range(-150,150)
	new_explosion_6.emitting = true
	
	await get_tree().create_timer(0.2).timeout
	#generate explosion effect, repeat five times then big explosion
	var new_explosion_7 = explosion_reference.instantiate()
	add_child(new_explosion_7)
	new_explosion_7.global_position.x = randf_range(25, 250)
	new_explosion_7.global_position.y += randf_range(-150,150)
	new_explosion_7.emitting = true
	
	await get_tree().create_timer(0.2).timeout
	#generate explosion effect, repeat five times then big explosion
	var new_explosion_4 = explosion_reference.instantiate()
	Global.root.entity_root.add_child(new_explosion_4)
	new_explosion_4.global_position = self.global_position
	new_explosion_4.lifetime = 3.0
	new_explosion_4.speed_scale = 10.0
	new_explosion_4.explosiveness = 1.0
	new_explosion_4.amount = 500
	new_explosion_4.emitting = true
	
	await get_tree().create_timer(0.3).timeout
	
	in_collapse_cutscene = false
	rubble1.emitting = false
	rubble2.emitting = false
	self.visible = false
	
	Global.root.show_level_clear_screen()
	await confirm
	Global.root.hide_level_clear_screen()
	
	#load the level below
	#Await the continue button being pressed
	#place the player in the new level, show the player and scroll the camera down
	Global.root.load_level(level_num + 1)
	
