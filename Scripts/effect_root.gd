extends Node2D


func add_effect(effect:Node2D):
	add_child(effect)
	print("effect added")


func print_message(message:String) -> void:
	print(message, " from Effect Root")
