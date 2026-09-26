extends Node2D


func _ready() -> void:
	Global.add_entity.connect(add_entity)

func add_entity(entity:Node2D):
	var pos = entity.global_position
	print("adding entity")
	if entity is FurniturePiece:
		entity.call_deferred("reparent",(self))
		entity.call_deferred("set_global_position",  pos)
	print("entity added")
