extends ExplosionBase

var damage_array: Array[int] = [0, 0, 0, 0,0]


func give_ult_array(ult_array:Array[int]) -> void:
	damage_array[0]= ult_array.size()
	var ult_explosion_particles = load("res://Scenes/ultimate_bomb_particles.tscn")
	for x in ult_array:
		var ult_explosion_particles_instance:GPUParticles2D = ult_explosion_particles.instantiate()
		add_child(ult_explosion_particles_instance)
		var path:String = "res://Materials/BombMaterials/"
		if x == 0:
			ult_explosion_particles_instance.process_material = load(path +"FireBombMaterial.tres")
			damage_array[1]+=1
		elif x ==1:
			ult_explosion_particles_instance.process_material = load(path +"WaterBombMaterial.tres")
			damage_array[2]+=1
		elif x ==2:
			ult_explosion_particles_instance.process_material = load(path +"PlantBombMaterial.tres")
			damage_array[3]+=1
		elif x ==3:
			ult_explosion_particles_instance.process_material = load(path +"AirBombMaterial.tres")
			damage_array[4]+=1
			
		ult_explosion_particles_instance.emitting = true
		  

func timer_timout() -> void:
	print("ult queue_freeing")
	super()

func damage(area:Node2D) -> void:
	#print("damage area sees: "+ str(area))
	var ray = RayCast2D.new()
	add_child(ray)
	
	#Detect if the explosion is through a wall
	ray.target_position = area.global_position - global_position
	ray.force_raycast_update()
	
	if not ray.is_colliding():
		if area.owner.has_method("damaged"): #|| area is Enemy || area is Destroyable:
			if type ==1:
				damage_array = [1, 1, 0, 0, 0]
			elif type ==2:
				damage_array = [1, 0, 1, 0, 0]
			elif type ==3:
				damage_array = [1, 0, 0, 1, 0]
			elif type ==4:
				damage_array = [1, 0, 0, 0, 1]
			area.owner.damaged(damage_array)
			print("damaged with ult, "+ str(damage_array))
