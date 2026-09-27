extends Area2D

var target:Vector2
var speed:int = 40
var tracking:bool = true

@onready var timer: Timer = $Timer

func _ready() -> void:
	body_entered.connect(body_entered_area)
	area_entered.connect(area_entered_hitbox)
	timer.timeout.connect(fizzle_out)

func get_target(new_target:Vector2):
	target = new_target

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if tracking:
		position.move_toward(target, delta * speed)

func body_entered_area(body:Node2D):
	if body.has_method("damaged"):
		var array: Array[int] = [1, 1, 0, 0, 0]
		body.damaged(array)
		tracking = false
		$GPUParticles2D2.emmiting = false
		timer.start()

func area_entered_hitbox(area: Area2D):
	if area.owner.has_method("damaged"):
		var array: Array[int] = [0, 1, 0, 0, 0]
		area.owner.damaged(array)
		tracking = false
		$GPUParticles2D2.emmiting = false
		timer.start()

func fizzle_out():
	queue_free()
