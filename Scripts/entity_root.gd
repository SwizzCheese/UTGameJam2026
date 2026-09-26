extends Node2D
##for signals and whatnot
@onready var effect_root: Node2D = $"../EffectRoot"

func add_entity(entity:Node2D):
	if entity is Bomb:
		entity.exploded.connect(bomb_exploded)
	if entity is FurniturePiece:
		print("furniture piece added")
	add_child(entity)
	print("entity added")


func bomb_exploded(type: int, global_pos:Vector2):
	var explosion_load = load("res://Scenes/explosion_base.tscn")
	var explosion_instance = explosion_load.instantiate()
	explosion_instance.global_position = global_pos
	effect_root.add_effect(explosion_instance)
	explosion_instance.receive_bomb_type(type)
	print("HI, bomb exploded (entity root)")
