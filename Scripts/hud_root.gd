extends Control

@onready var health: Node2D = $Health

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.player_died.connect(player_died)
	Global.player_hurt.connect(redraw_hearts)
	


func redraw_hearts(lives: int) -> void:
	print("Player hurt (HUD)")
	health.playerhurt(lives)

func player_died() -> void:
	print("Player died (HUD)")
