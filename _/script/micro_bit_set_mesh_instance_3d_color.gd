extends Node

@export var to_affect : MeshInstance3D =null


func set_color_of_the_mesh_material(new_color:Color):
	to_affect.get_active_material(0).albedo_color = new_color
