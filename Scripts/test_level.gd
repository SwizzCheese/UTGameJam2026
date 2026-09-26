extends BaseLevel

@onready var camera_2d: Camera2D = $Camera2D
@onready var marker_2d: Marker2D = $PlayerSpawn


func get_default_player_spawn() -> Vector2:
	
	return marker_2d.position



## Provides the camera used in the level:
func get_player_camera() -> Camera2D:
	
	return camera_2d
