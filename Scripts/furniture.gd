extends PushableRigidBody


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Timer.timeout.connect(timeout)
	for x in $Pieces.get_children():
		x.leave.connect(check_if_empty)

func check_if_empty():
	$Timer.start()

func timeout():
	if $Pieces.get_children() == null:
		queue_free()
		print("furniture fully destroyed")
