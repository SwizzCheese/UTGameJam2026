extends StaticBody2D



func _ready() -> void:
	pass



func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("explosion"):
		owner.pillar_destroyed()
		# play destroyed animation
		# await destroyed animation finish
		queue_free()
	
