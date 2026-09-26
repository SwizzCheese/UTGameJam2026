class_name ExplosionBase extends Node2D

@export var time:float  = 1 #time it takes for explosion to reach max/min values
var type: int

@export var max_radius:float #maximum radius of blast
var current_radius:float = 0

#damage
@export var max_power: int #max power of explosion (beginning of explosion)
@export var min_power: int #min power of explosion (end of explosion)
var current_power:float

#push force
@export var max_push: float #max push of explosion (beginning of explosion)
@export var min_push: float #min push of explosion (end of explosion)
var current_push:float

@onready var Explosion_Collision: CollisionShape2D = $ExplosionArea/Explosion_Collision
@onready var timer: Timer = $Timer
@onready var bomb_particles: GPUParticles2D = $BombParticles



#TWEENS
var radius_tween:Tween
var power_tween:Tween
var push_tween:Tween


func _ready() -> void:
	
	current_power = max_power
	current_push = max_push
	$ExplosionArea.body_entered.connect(on_entered)
	$ExplosionArea.area_entered.connect(damage)
	
	#timer
	timer.wait_time = time
	timer.timeout.connect(timer_timout)
	timer.start()
	
	#tweens
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
	#print("push is : "+ str(current_push))

func on_entered(body:Node2D):
	print(body.get_class())
	var dir:Vector2 = body.global_position - self.global_position
	if body is PushableCharBody:
		print("I SEE YOU: "+ str(body))
		body.pushed(dir.normalized(), current_push)
	if body.is_in_group("PushableRigid"):
		#print("HELP ME!!!!!!!!!!!!!!")
		body.pushed(dir.normalized(), current_push)
		#apply_impulse((strength * direction, origin of impulse)
		pass

func timer_timout() -> void:
	queue_free()

#receives the bomb type and assigns correct material to BombParticles
func receive_bomb_type(bomb_type:int) -> void:
	var path:String = "res://Materials/BombMaterials/"
	if bomb_type == 1:
		bomb_particles.process_material = load(path +"FireBombMaterial.tres")
	elif bomb_type ==2:
		bomb_particles.process_material = load(path +"WaterBombMaterial.tres")
	elif bomb_type ==3:
		bomb_particles.process_material = load(path +"PlantBombMaterial.tres")
	elif bomb_type ==4:
		bomb_particles.process_material = load(path +"AirBombMaterial.tres")
	print(str(bomb_particles.process_material))
	bomb_particles.emitting = true
	#print("type material correctly loaded (explosion_base)")

func damage(area:Node2D) -> void:
	print("damage area sees: "+ str(area))
	if area.owner.has_method("damaged"): #|| area is Enemy || area is Destroyable:
		print("damaging player")
		var damage_array:Array[int] = [1, 0, 0, 0, 0]
		if type ==1:
			damage_array== [1, 1, 0, 0, 0]
		elif type ==2:
			damage_array== [1, 0, 1, 0, 0]
		elif type ==3:
			damage_array== [1, 0, 0, 1, 0]
		elif type ==4:
			damage_array== [1, 0, 0, 0, 1]
		area.owner.damaged(damage_array)
