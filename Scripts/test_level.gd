extends BaseLevel

#@onready var camera_2d: Camera2D = $Camera2D
@onready var marker_2d: Marker2D = $PlayerSpawn
@onready var countdown_timer : Timer = $CountdownTimer
@onready var exit : Node2D = $Exit
@export var level_num : int
signal confirm

func _ready() -> void:
	countdown_timer.timeout.connect(countdown_failed)
	i_won = false
	

func _input(event: InputEvent) -> void:
	if event.is_action("throw_bomb"):
		confirm.emit()

## Provides the player spawn point:
func get_default_player_spawn() -> Vector2:
	return marker_2d.position

## Provides the camera used in the level:
#func get_player_camera() -> Camera2D:
	#return camera_2d


func pillar_destroyed():
	pillars -= 1
	
	if pillars <= 0:
		start_countdown()


func start_countdown():
	Global.give_HUD_time.emit(countdown_timer.wait_time)
	countdown_timer.start()
	exit.open_exit()

func countdown_failed():
	if !i_won and Global.player != null:
		Global.player.destroyed()
	countdown_timer.stop()

func level_cleared():
	Global.level_won.emit()
	i_won = true
	countdown_timer.stop()
	Global.player.visible = false
	Global.player.in_cutscene = true
	#play the exploding floor animation
	Global.root.show_level_clear_screen()
	await confirm
	Global.root.hide_level_clear_screen()
	
	#load the level below
	#Await the continue button being pressed
	#place the player in the new level, show the player and scroll the camera down
	Global.root.load_level(level_num + 1)
	
