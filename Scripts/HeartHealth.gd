extends HBoxContainer


# Called when the node enters the scene tree for the first time.

	

	

var Health = 3
var heartz : Array[TextureRect] = [$Heart,$Heart2,$Heart3]

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("add_heart"):
		playerrep(1)
			
	if event.is_action_pressed("removehart"):
		playerhurt(1)
					
		
		
		
			
		
func playerhurt(lost: int):
	#loses health
	for loop: int in Health-lost:
		heartz[Health-lost].visible = 1 < Health
		Health -= 1
func playerrep(rep: int):
	#replinishes health
	for loop: int in Health+rep:
		heartz[Health+rep].visible = 1 >Health
		Health += 1
				
func respawnz():
	#respawns all the health back
	for Health in heartz:
		heartz[Health].visible		
					
	
