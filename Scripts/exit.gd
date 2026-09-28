extends Node2D

var player_in_area : bool
var exit_open : bool
@onready var sprite : Sprite2D = $Sprite2D
@onready var arrow : Sprite2D = $arrow
func _ready() -> void:
	sprite.frame = 0
	player_in_area = false
	exit_open = false
	arrow.visible = false



func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("down") and player_in_area and exit_open:
		owner.level_cleared()

func open_exit():
	sprite.frame = 1
	exit_open = true
	arrow.visible = true


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		player_in_area = true


func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.is_in_group("player"):
		player_in_area = false
