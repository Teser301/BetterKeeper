extends NavigationRegion3D

@onready var navMesh: NavigationRegion3D = $"."
@onready var grid:GridMap = $GridMap


const FLOOR = 0
const WALL = 1

func _ready():
	var mesh = NavigationMesh.new()
	mesh.geometry_parsed_geometry_type = NavigationMesh.PARSED_GEOMETRY_STATIC_COLLIDERS
	mesh.cell_height = 0.1
	mesh.agent_radius = 0.
	mesh.agent_max_climb = 0.1
	mesh.resource_local_to_scene
	navMesh.navigation_mesh = mesh
	navMesh.bake_navigation_mesh()
	

func _input(event):
	if Input.is_action_pressed("left_click"):
		var mouse = _shoot_ray()
		var point: Vector3i = grid.local_to_map(mouse)
		
		if not point:
			return

		point.y = 0
		grid.set_cell_item(point, 0)
		navMesh.bake_navigation_mesh()
		pass

func _shoot_ray():
	var mouse_pos = get_viewport().get_mouse_position()
	var ray_length = 1000

	var from = get_viewport().get_camera_3d().project_ray_origin(mouse_pos)
	var to = from + get_viewport().get_camera_3d().project_ray_normal(mouse_pos) * ray_length

	var direction = (to - from).normalized()

	if direction.y != 0:
		var distance = -from.y / direction.y
		var intersection_point = from + direction * distance
		return intersection_point

	return null

	
func _process(delta):
	pass
