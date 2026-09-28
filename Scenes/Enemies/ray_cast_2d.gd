extends RayCast2D

@onready var push_timer = $PushTimer
@onready var ray_cast_2d: RayCast2D = $"."
var MyHeart = load("res://Scripts/HeartHealth.gd")
var myHeart_instance = MyHeart.new()
@onready var line_2d: Line2D = $Line2D



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _physics_process(delta: float) -> void:
	if get_collider() is Player:
		var hitpoint =ray_cast_2d.get_collision_point()
		line_2d.add_point(hitpoint)
		get_collider().Player.damaged([1,0,0,0,0])
		
	
		
			
	
		
	
 	
	
	
