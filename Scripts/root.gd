extends Node


var scene_path:String = "res://Scenes/Levels/"
var next_level_num:int #the next level
var level:Level
var max_easy_level:int = 2 #maximum level num for easy levels
var max_medium_level:int = 1 #maximum level num for medium levels
var max_hard_level:int = 1 #maximum level num for hard levels


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	next_level_num = get_random_level("easy")
	change_to_level(next_level_num)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("test_level"):
		print("Hi, changing level")
		get_random_level("easy")
		change_to_level(next_level_num)

#region Level funcs
func change_to_level(level_num:int):
	if $World/LevelRoot.get_child_count() != 0:
		level = $World/LevelRoot.get_child(0)
	var full_path = scene_path + "/level_"+str(level_num) + ".tscn"
	var new_level_scene:PackedScene = load(full_path) #make packed scene
	var new_level = new_level_scene.instantiate()
	$World/LevelRoot.add_child(new_level)
	if level != null:
		level.queue_free()
	level = new_level

#for level gen
func get_random_level(difficulty:String):
	var level_num:int = 0
	if difficulty == "easy":
		level_num = (randi()% max_easy_level) +1
		print("new level is: "+str(level_num))
	elif difficulty == "easy":
		level_num = 2
	else:
		level_num = 3
	next_level_num = level_num
	return level_num
#endregion
