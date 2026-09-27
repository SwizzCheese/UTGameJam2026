extends Node2D
##for signals and whatnot
@onready var effect_root: Node2D = $"../EffectRoot"

func add_entity(entity:Node2D):
	var pos = entity.global_position
	if entity is Bomb:
		entity.exploded.connect(bomb_exploded)
	elif entity is FurniturePiece:
		entity.call_deferred("reparent",(self))
		entity.call_deferred("set_global_position",  pos)
	else:
		entity.call_deferred("reparent",(self))
		entity.call_deferred("set_global_position",  pos)
	add_child(entity)
	print("entity added")


func bomb_exploded(type: int, global_pos:Vector2):
	var explosion_load = load("res://Scenes/explosion_base.tscn")
	var explosion_instance = explosion_load.instantiate()
	explosion_instance.global_position = global_pos
	effect_root.add_effect(explosion_instance)
	explosion_instance.receive_bomb_type(type)
	print("HI, bomb exploded (entity root)")
