extends MeshInstance3D

@export var player: Node3D
@export var anchor: Node3D

var line_mesh := ImmediateMesh.new()

func _ready() -> void:
	mesh = line_mesh

func _process(delta: float) -> void:
	line_mesh.clear_surfaces()
	line_mesh.surface_begin(Mesh.PRIMITIVE_LINES)
	line_mesh.surface_add_vertex(to_local(player.global_position))
	line_mesh.surface_add_vertex(to_local(anchor.global_position))
	line_mesh.surface_end()
