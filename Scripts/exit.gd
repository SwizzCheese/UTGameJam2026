extends Node2D

var player_in_area : bool
var exit_open : bool

func _ready() -> void:
	#Set sprite to closed variant
	player_in_area = false
	exit_open = false



func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("down") and player_in_area and exit_open:
		owner.level_cleared()

func open_exit():
	#Set sprite to open variant
	exit_open = true


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		player_in_area = true


func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.is_in_group("player"):
		player_in_area = false
