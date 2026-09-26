class_name ExplosionBase extends Node2D

@export var time:float #time it takes for explosion to reach max/min values

@export var max_radius:float #maximum radius of blast
var current_radius:float = 0

#damage
@export var max_power: int #max power of explosion (beginning of explosion)
@export var min_power: int #min power of explosion (end of explosion)
var current_power:float = max_power

#push force
@export var max_push: float #max push of explosion (beginning of explosion)
@export var min_push: float #min push of explosion (end of explosion)
var current_push:float = max_push

@onready var Explosion_Collision: CollisionShape2D = $ExplosionArea/Explosion_Collision

#TWEENS
var radius_tween:Tween
var power_tween:Tween
var push_tween:Tween


func _ready() -> void:
	$ExplosionArea.body_entered.connect(on_entered)
	radius_tween = create_tween()
	power_tween = create_tween()
	push_tween = create_tween()
	radius_tween.tween_property(self,"current_radius", max_radius, time).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)
	power_tween.tween_property(self,"current_power", min_power, time).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_IN_OUT)
	push_tween.tween_property(self,"current_push", min_push, time).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_OUT)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	Explosion_Collision.scale = Vector2(current_radius, current_radius)
	#print("radius is : "+ str(current_radius))
	#print("power is : "+ str(current_power))

#func on_entered(body):
#	var dir = body.global_position - global_position
#	if body.is_in_group("PushableBodies"):
#		(body as PushableBody).pushed(dir, current_push)
#		#velocity += dir* current_push
#	if body.is_in_group("PushableRigid"):
#		body.pushed(dir.normalized(), current_push)
#		#apply_impulse((strength * direction, origin of impulse)
#		pass
		#apply force(direction, power)
func on_entered(body:Node2D):
	var dir = body.global_position - global_position
	if body.is_in_group("PushableBodies"):
		body.pushed(dir.normalized(), current_push)
		#velocity += dir* current_push
	if body.is_in_group("PushableRigid"):
		body.pushed((current_push * dir.normalized()), global_position)
		#apply_impulse((strength * direction, origin of impulse)
