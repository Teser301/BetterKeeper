extends NavigationRegion3D

@onready var navMesh: NavigationRegion3D = $"."
@onready var grid:GridMap = $"GridMap"

var chunk

const CHUNK_SIZE = 22
const HALF_CHUNK_SIZE = CHUNK_SIZE / 2

const FLOOR = 0
const WALL = 1

func _ready():
	var mesh = NavigationMesh.new()
	mesh.geometry_parsed_geometry_type = NavigationMesh.PARSED_GEOMETRY_STATIC_COLLIDERS
	mesh.cell_height = 0.1
	mesh.cell_size = 0.1
	mesh.agent_radius = 0.1
	mesh.agent_max_climb = 0.1
	navMesh.navigation_mesh = mesh
	
	var global_position = global_transform.origin
	
	var chunk_x = int(global_position.x / CHUNK_SIZE)
	var chunk_z = int(global_position.z / CHUNK_SIZE)
	
	chunk = Vector2(chunk_x, chunk_z)
	
	print("Chunk: ", chunk)
	
	await get_tree().process_frame

	navMesh.bake_navigation_mesh()
	

func _input(event):
	if Input.is_action_pressed("left_click"):
		var mouse = _shoot_ray()
		if not is_point_in_current_chunk(mouse):
			return

		var point: Vector3i = grid.local_to_map(to_local(mouse))
		
		if not point:
			return
		if grid.get_cell_item(point) == FLOOR:
			return
		
		point.y = 0
		grid.set_cell_item(point, 0)
		
		await get_tree().process_frame
		navMesh.bake_navigation_mesh()


func is_point_in_current_chunk(point: Vector3) -> bool:
	var chunk_x = int(floor(point.x / CHUNK_SIZE))
	var chunk_z = int(floor(point.z / CHUNK_SIZE))
	var point_chunk = Vector2(chunk_x, chunk_z)
	return point_chunk == chunk


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

