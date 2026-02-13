extends Node3D


@onready var grid_map: GridMap = $GridMap
@onready var camera: Camera3D = %Camera
@onready var floor_plane: Plane = $Floor/CollisionShape.shape.plane


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _process(delta: float) -> void:
	if Input.is_action_pressed("interact"):
		var viewport = get_viewport()
		var mouse_pos = viewport.get_mouse_position()
		
		var origin = camera.project_ray_origin(mouse_pos)
		var normal = camera.project_ray_normal(mouse_pos)
		
		var intersection = floor_plane.intersects_ray(origin, normal)
		
		var grid_pos = grid_map.local_to_map(grid_map.to_local(intersection))
		grid_map.set_cell_item(grid_pos, 0)
