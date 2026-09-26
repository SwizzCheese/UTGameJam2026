extends Resource

@export var type:int #type of bomb (1 = fire, 2 = Water, 3 = Earth, 4 = wind)

@export var range:float
@export var max_power:float
@export var min_power:float
@export var max_push:float
@export var min_push:float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
