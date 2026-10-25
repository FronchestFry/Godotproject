extends Area3D

func _ready():
	body_entered.connect(hit)

func hit(body):
	if body.is_in_group("enemies"):
		body.get_parent().health -= 1
		self.get_parent().reparent(body, true)
		self.get_parent().freeze = true
