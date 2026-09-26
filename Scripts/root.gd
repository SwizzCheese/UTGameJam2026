extends Node2D


var scene_path:String = "res://Scenes/Levels/"
var next_level_num:int #the next level
var level:Level
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	next_level_num = get_random_level("easy")
	change_to_level(next_level_num)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


#region Level funcs


func change_to_level(level_num:int):
	if $LevelRoot.get_child_count() != 0:
		level = $LevelRoot.get_child(0)
	var full_path = scene_path + "/level_"+str(level_num) + ".tscn"
	var new_level_scene:PackedScene = load(full_path) #make packed scene
	var new_level = new_level_scene.instantiate()
	$LevelRoot.add_child(new_level)
	if level != null:
		level.queue_free()
	level = new_level

#for level gen
func get_random_level(difficulty:String):
	var level_num:int = 0
	if difficulty == "easy":
		level_num = 1
	elif difficulty == "easy":
		level_num = 2
	else:
		level_num = 3
	return level_num
#endregion
