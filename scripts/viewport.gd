extends SubViewport

@onready var camera: GameCamera = %Camera
@onready var ray_cast: RayCast3D = %Camera/InteractableRayCast


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		var mouse_pos := get_mouse_position()
		var normalized := Vector2(mouse_pos.x / size.x, 1.0 - (mouse_pos.y / size.y)) - Vector2(0.5, 0.5)
		var new_raycast_position := camera._get_size_vector() * normalized

		ray_cast.position = Vector3(new_raycast_position.x, new_raycast_position.y, 0.0)
		print(ray_cast.position)
		ray_cast.force_raycast_update()

		if ray_cast.is_colliding():
			var collider := ray_cast.get_collider() as Node3D
			var parent := collider.get_parent()

			if parent is InteractableComponent:
				parent._interacted_with()
			else:
				push_error(name, " collided with ", collider, " which is not part of an InteractableComponent.")
