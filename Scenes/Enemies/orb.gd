extends Area2D

#each life the orb loses, it shoots a projectile
#weak to wind
@onready var invincible_timer: Timer = $InvincibleTimer

var speed = 20
var lives:int = 6 
var invincible:bool = false

func _process(delta: float) -> void:
	pass

func damaged(damage_array:Array[int]):
	invincible = true
	$CollisionShape2D.set_deferred("disabled", true)
	invincible_timer.start()
	if damage_array[4]>=1: #double damage to plants
		for x in range(0, damage_array[4]):
			lives -=1
			if lives <=0:
				destroy()
			spawn_projectile()
			lives -=1
			if lives <=0:
				destroy()
			spawn_projectile()
	else:
		for x in range(0, damage_array[0]):
			lives -=1
			if lives <=0:
				destroy()
			spawn_projectile()
		
func destroy():
	queue_free()

func spawn_projectile():
	var target = Global.player.global_position - global_position
	var projectile_load = load("res://Scenes/Enemies/orb_projectile.tscn")
	var projectile_instance = projectile_load.instantiate()
	projectile_instance.global_position = global_position
	projectile_instance.get_target(target)
	Global.add_entity.emit(projectile_instance)
	
func noninvincible()->void:
	invincible = false
	$CollisionShape2D.set_deferred("disabled", true)
	
