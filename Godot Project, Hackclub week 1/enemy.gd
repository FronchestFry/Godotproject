extends Node3D

var health = 3

func _physics_process(delta: float) -> void:
	if health <= 0:
		queue_free()
