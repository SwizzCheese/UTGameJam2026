
		
extends HBoxContainer

@onready var fire = $Spell2
@onready var water =$Spell4
@onready var wind = $Spell3
@onready var life = $Spell1

# Called when the node enters the scene tree for the first time.
func _input(event: InputEvent) -> void:
	
	if event.is_action_pressed("change_spell"):
		modulatespells()

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
			fire.modulate = Color(0.031, 0.053, 0.022, 1.0)
	
	
	
func modulatewind():
			wind.modulate = Color(0.031, 0.053, 0.022, 1.0)
			
func modulatelife():
			life.modulate = Color(0.031, 0.053, 0.022, 1.0)
			
func modulatewater():
			water.modulate = Color(0.031, 0.053, 0.022, 1.0)
	
	
	
	
