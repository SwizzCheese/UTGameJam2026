
		
extends HBoxContainer

@onready var fire = $Spell2
@onready var water =$Spell4
@onready var wind = $Spell3
@onready var life = $Spell1
var current_spell:int = 0
var greyed_out:Color =  Color(0.031, 0.053, 0.022, .5)


func _ready() -> void:
	modulatewater()
	modulatelife()
	modulatewind()

func _input(event: InputEvent) -> void:
	
	if event.is_action_pressed("change_spell"):
		#modulatespells()
		increase_spell()

func modulatespells():
			
	for i in range(4):
		i +=1
		if i == 1:
				modulatefire()
		if i ==2:
				modulatewind()
		if i ==3:
				modulatelife()
		if i == 4:
				modulatewater()
func modulatefire():
			fire.modulate = greyed_out
	
func modulatewind():
			wind.modulate = greyed_out
			
func modulatelife():
			life.modulate = greyed_out
			
func modulatewater():
			water.modulate = greyed_out
	
func clear(spell:Sprite2D):
	spell.modulate = Color.WHITE


func increase_spell() -> void:
	if current_spell >=3:
		current_spell = 0
	else:
		current_spell +=1
	
	match current_spell:
		0: #fire
			modulatewind()
			clear(fire)
		1: #water
			modulatefire()
			clear(water)
		2: #life/earth/plants
			modulatewater()
			clear(life)
		3: #air.wind
			modulatelife()
			clear(wind)
		
