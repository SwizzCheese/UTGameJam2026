@abstract
class_name BaseLevel
extends Node2D
## Abstract class for levels

var pillars : int
var countdown_time : float
var i_won : bool


## Provides a player spawn location
@abstract func get_default_player_spawn() -> Vector2

## Provides the camera used in the level
@abstract func get_player_camera() -> Camera2D

## Counts down the pillar count until triggering end-level sequence
@abstract func pillar_destroyed()

## Tells the root that the level is cleared
@abstract func level_cleared()

## Starts the end-level sequence
@abstract func start_countdown()

## Tells the player and the explosion FX that the countdown has been failed, so kill the player
@abstract func countdown_failed()
