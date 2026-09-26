extends HBoxContainer


# Called when the node enters the scene tree for the first time.

	

	

var Health = 3
var heartz : Array[TextureRect] = [$Heart,$Heart2,$Heart3]
		
			
			
		
		
		
			
		
func playerhurt(lost: int):
	for loop: int in Health-lost:
		heartz[Health-lost].visible = 1 < Health
		Health -= 1
func playerrep(rep: int):
	for loop: int in Health+rep:
		heartz[Health+rep].visible = 1 >Health
		Health += 1
				
func respawnz():
	for Health in heartz:
		heartz[Health].visible		
					
	
