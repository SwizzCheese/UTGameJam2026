extends HBoxContainer


# Called when the node enters the scene tree for the first time.

	

	

var Health = 3
@onready var heartz : Array[TextureRect] = [$Heart,$Heart2,$Heart3]

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("add_heart"):
		playerrep(1)
			
	if event.is_action_pressed("removehart"):
		playerhurt(1)
					
		
		
		
			
		
func playerhurt(lost: int):
	#loses health
	print("current health is: "+ str(lost)+ " hearts\nHealth is : "+ str(Health))
	for  i in range(0, Health-lost):
		heartz[Health-i-1].hide()
		Health -= 1

func playerrep(rep: int):
	#replinishes health
	for i in range(0, rep-Health):
		heartz[Health+i].show() 
		Health += 1
				
func respawnz():
	#respawns all the health back
	for  i in Health:
		heartz[Health].show()	
					
	
