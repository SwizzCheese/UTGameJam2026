extends Node2D


func playerhurt(lost: int):
	$Health/HBoxContainer.playerhurt(lost)

func playerrep(rep: int):
	#replinishes health
	$Health/HBoxContainer.playerrep(rep)
				
func respawnz():
	#respawns all the health back
	$Health/HBoxContainer.respawnz()
					
