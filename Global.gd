extends Node
#It's the Global script. You put things that everything needs access
# to in here

var player : Player
var root : GameRoot

signal player_hurt(int)
signal player_died

signal add_entity(entity:Node2D)
signal give_HUD_time(seconds:float)
signal level_won

signal return_to_menu
