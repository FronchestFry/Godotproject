extends MeshInstance3D

@export var player: Node3D
@export var anchor: Node3D
var orb



var line_mesh := ImmediateMesh.new()
var line_material := StandardMaterial3D.new()

func _ready() -> void:
	orb = player.get_node('Neck/Head/Hand/Orb')
	mesh = line_mesh
	
	line_material.albedo_color = Color.AQUA
	line_material.emission_enabled = true
	line_material.emission_energy_multiplier = 1
	line_material.emission = Color.CORNFLOWER_BLUE

func _process(delta: float) -> void:
	if player.alo_equipped and not player.coin_pocketed:
		self.show()
		line_mesh.clear_surfaces()
		line_mesh.surface_begin(Mesh.PRIMITIVE_LINES, line_material)
		line_mesh.surface_add_vertex(to_local(orb.global_position))
		line_mesh.surface_add_vertex(to_local(anchor.global_position))
		line_mesh.surface_end()
	else:
		self.hide()
