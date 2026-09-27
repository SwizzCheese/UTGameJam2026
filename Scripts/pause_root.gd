extends Control


func show_death_screen() -> void:
	get_tree().paused = true
	$DeathScreen.open_death_screen()

func show_pause_screen() -> void:
	get_tree().paused = true
	$PauseScreen.open_pause_screen()
