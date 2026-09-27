extends Node2D

@onready var ray_cast: RayCast2D = $RayCast2D
@onready var anisprite: AnimatedSprite2D = $AnimatedSprite2D




var speed = 20
var lives:int = 1


func _ready() -> void:
	lives = 1
	$FireMonster.body_entered.connect(body_entered_area)


func _physics_process(delta: float) -> void:
	if Global.player != null:
		ray_cast.target_position = Global.player.position - ray_cast.global_position
		if ray_cast.is_colliding() == false:
			anisprite.play("chase")
			if global_position.x < ray_cast.target_position.x:
				anisprite.flip_h = true
			elif global_position.x > ray_cast.target_position.x:
				anisprite.flip_h = false
			position = (position.move_toward(ray_cast.target_position, delta * speed))
		else:
			anisprite.play("idle")
	

func body_entered_area(body:Node2D):
	if body.has_method("damaged"):
		var array: Array[int] = [1, 1, 0, 0, 0]
		body.damaged(array)

func area_entered_hitbox(area: Area2D):
	if area.owner.has_method("damaged"):
		var array: Array[int] = [0, 1, 0, 0, 0]
		area.owner.damaged(array)

func damaged(damage_array:Array[int]):
	if damage_array[2]>=1:
		destroy()

func destroy():
	queue_free()
