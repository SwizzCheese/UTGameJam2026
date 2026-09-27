class_name FurniturePiece extends PushableRigidBody

signal leave
@export var flip_h:bool
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#body_entered.connect(cede_from_union) #body entered
	$Area2D.area_entered.connect(form_sovereign_nation) #area_entered
	if flip_h:
		$Sprite2D.flip_h = true


#body_entered
#func cede_from_union(body:Node2D):
#	if body is Player:
#		pass

#area_entered
func form_sovereign_nation(area:Node2D):
	if area.owner is ExplosionBase:
		flee_the_country()

#move to EntityRoot, then queuefree()
func flee_the_country() -> void:
	$Area2D.queue_free()
	Global.add_entity.emit(self)
	leave.emit()

func pushed(dir:Vector2, strength:float):#origin:Vector2
	#vel = velocity = power * direction, origin = origin of blast
	apply_impulse(dir * strength*10)
	print("impulse applied, strength: "+str(strength))
