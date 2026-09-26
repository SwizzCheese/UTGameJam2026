extends Node
#It's the Global script. You put things that everything needs access
# to in here

var player : Player

signal player_hurt(int)
signal player_died

signal add_entity(entity:Node2D)
