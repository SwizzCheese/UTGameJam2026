extends BaseLevel

@onready var camera_2d: Camera2D = $Camera2D
@onready var marker_2d: Marker2D = $PlayerSpawn
@onready var countdown_timer : Timer = $CountdownTimer
@onready var exit : Node2D = $Exit
@export var level_num : int

func _ready() -> void:
	pillars = 1
	countdown_timer.timeout.connect(countdown_failed)
	i_won = false
	

## Provides the player spawn point:
func get_default_player_spawn() -> Vector2:
	return marker_2d.position

## Provides the camera used in the level:
func get_player_camera() -> Camera2D:
	return camera_2d


func pillar_destroyed():
	pillars -= 1
	
	if pillars <= 0:
		start_countdown()


func start_countdown():
	countdown_timer.start()
	exit.open_exit()

func countdown_failed():
	if !i_won:
		Global.player.destroyed()
	countdown_timer.stop()

func level_cleared():
	i_won = true
	countdown_timer.stop()
	#play the exploding floor animation
	#show the results screen
	#load the level below
	#Await the continue button being pressed
	#place the player in the new level and scroll the camera down
	Global.root.load_level(level_num + 2)
