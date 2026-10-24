extends Label3D

@onready var anchor = get_parent().get_parent().get_node('Anchor')

func _physics_process(delta: float) -> void:
	if anchor.get_global_position().y >= -0.1:
		text = "Good. It is recomended to use high forces to launch yourself, and low ones to move the coin, as it is much lighter than you. \n Now scale the wall."
	else:
		text = "Good. The force moves in a straight line between the coin and you, though gravity still fights against it. \n Stand at the edge and pull your coin up after you, you'll need it in the trials to come."
