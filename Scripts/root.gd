class_name GameRoot
extends Node
## Main entry point for the game
## Responsible for setting up the world layers and coordinating systems


# TODO (main menu) to load test level and quit
const TEST_LEVEL : String = "uid://c544myatnf6i6"
const WORLD_PLAYER : String = "uid://dntp6ubf0fjog"


var player : Player = null

var current_difficulty : int
var levels_cleared : int

var scene_path : String = "res://Scenes/Levels/"
var _current_level : BaseLevel = null
var max_easy_level : int = 2
var max_medium_level : int = 4
var max_hard_level : int = 6





# Game World root nodes
@onready var level_root: Node2D = $World/LevelRoot
@onready var entity_root: Node2D = $World/EntityRoot
@onready var effect_root: Node2D = $World/EffectRoot

# UI Root nodes
@onready var hud_root: Control = $HudLayer/HudRoot
@onready var pause_root: Control = $PauseLayer/PauseRoot
@onready var transition_root: Control = $TransitionLayer/TransitionRoot




func _ready() -> void:
	_init_player()
	
	load_level(get_random_level(1))



func _init_player() -> void:
	
	var player_scene : PackedScene = ResourceLoader.load(WORLD_PLAYER) as PackedScene
	if player_scene == null:
		push_error("Could not load player scene: " + WORLD_PLAYER)
		return
	
	player = player_scene.instantiate() as Player
	
	if player == null:
		push_error("Loaded player scene does not extend player or DNE: " + WORLD_PLAYER)
		return
	Global.player = player
	entity_root.add_child(player)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		pause_root.show_pause_screen()
	pass


func load_level(level_num : int) -> void:
	# Must be called during "Idle Time" so that the loading doesn't get messed up
	_deferred_load_level.call_deferred(level_num)
	

func _deferred_load_level(level_num) -> void:
	#clear the current level
	if _current_level != null:
		_current_level.queue_free()
		_current_level = null
	
	#wait for the level to finish clearing
	await get_tree().process_frame
	
	var full_path = scene_path + "level_" + str(level_num) + ".tscn"
	var new_level_packed : PackedScene =\
		ResourceLoader.load(full_path, "PackedScene") as PackedScene
	if new_level_packed == null:
		push_error("Could not load level as a packed scene: " + str(level_num))
		return
	
	_current_level = new_level_packed.instantiate() as BaseLevel
	if _current_level == null:
		push_error("Loaded level is not of BaseLevel type or does not exist")
		return
	# TODO (main menu): should have a fall back scene
	
	level_root.add_child(_current_level)
	
	#allow level to fully process before accessing it
	await get_tree().process_frame
	_place_player_at_level_spawn()
	_setup_level_camera()



func get_random_level(difficulty : int) -> int:
	var level_num:int = 0
	if difficulty == 1:
		level_num = (randi()% max_easy_level) +1
		print("new level is: " + str(level_num))
	elif difficulty == 2:
		level_num = (randi()% max_medium_level) +51
		print("new level is: " + str(level_num))
	else:
		level_num = (randi()% max_hard_level) +101
		print("new level is: " + str(level_num))
	
	
	return level_num





## Finds the default spawn location in currently loaded level, and places the player there
func _place_player_at_level_spawn() -> void:
	if player == null:
		push_error("Cannot place player in level because player is null")
		return
	if _current_level == null:
		push_error("Cannot place player in level because level is null")
		return
	
	player.global_position = _current_level.get_default_player_spawn()


## Attaches player to the current camera as the target
func _setup_level_camera() -> void:
	if player == null or _current_level == null:
		return
	
	var level_camera : Camera2D = _current_level.get_player_camera()
	if level_camera == null:
		return
	
	#level_camera.target = player
	# TODO add a fallback camera
	# Eventually separate this into the camera system as camera_system.set_target(player)
	#level_camera.target = player
