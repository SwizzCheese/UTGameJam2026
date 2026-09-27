extends Control

@onready var timer: Timer = $Timer
@onready var label: Label = $Label


func _ready() -> void:
	timer.start()
	Global.give_HUD_time.connect(receive_time)
	Global.level_won.connect(pause_timer)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	label.text = str(int(timer.time_left))
	if timer.time_left<=5:
		label.modulate = Color(100, 0, 0)

func receive_time(seconds:float) -> void:
	print("HUD received wait time: "+str(seconds))
	timer.start(seconds)

func pause_timer() -> void:
	timer.paused = true
