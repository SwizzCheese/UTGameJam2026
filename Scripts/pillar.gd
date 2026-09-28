extends StaticBody2D



func _ready() -> void:
	for child in $Pieces.get_children():
		child.freeze = true



func _on_hitbox_area_entered(area: Area2D) -> void:
	var ray = RayCast2D.new()
	add_child(ray)
	
	#Detect if the explosion is through a wall
	ray.target_position = area.global_position - global_position
	ray.force_raycast_update()
	
	if not ray.is_colliding():
		if area.is_in_group("explosion"):
			owner.pillar_destroyed()
			# play destroyed animation
			# await destroyed animation finish
			for child in $Pieces.get_children():
				child.set_deferred("freeze", false)
			$CollisionShape2D.queue_free()
			$Sprite2D.queue_free()
			$hitbox.queue_free()
			#queue_free()
	
