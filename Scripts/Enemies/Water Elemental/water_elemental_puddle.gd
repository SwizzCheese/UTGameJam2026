extends Node2D

@export var water_elemental_scene: PackedScene
@onready var sprite = $AnimatedSprite2D
@onready var particles = $CPUParticles2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sprite.play("Peeking")
	particles.emitting = true
	await get_tree().create_timer(3.0).timeout
	_spawn_baby()

func _spawn_baby() -> void:
	print("Attempting spawn, scene assigned: ", water_elemental_scene != null)
	if water_elemental_scene:
		var elemental = water_elemental_scene.instantiate()
		get_tree().current_scene.add_child(elemental)
		elemental.global_position = global_position
	queue_free()
