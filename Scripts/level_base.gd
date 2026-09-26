class_name Level extends Node2D

@export var level_num:int #unique level num 1-50 for easy, 51-100 for med, 101-150 for hard

var resource:Resource


## Provides a player spawn location
func get_default_player_spawn() -> Vector2:
	return $player_spawn.global_position

## Provides the camera used in the level
#func get_player_camera() -> Camera2D:
#	pass
