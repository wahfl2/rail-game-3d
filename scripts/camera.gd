extends Camera3D

class_name GameCamera

const MIN_ZOOM = 10
const MAX_ZOOM = 100
const DEFAULT_POSITION = Vector3(0, 100, 100)

@onready var size_vector := _get_size_vector()

@onready var container: SubViewportContainer = $"../../.."
@onready var player: CharacterBody3D = $".."


func _get_size_vector() -> Vector2:
	var vp_size = get_viewport().size
	var aspect = (vp_size.x + 0.0) / vp_size.y

	return Vector2(aspect * size, size)


func world_tex_size() -> Vector3:
	var aspect = container.size.x / container.size.y
	var size_m = Vector2(size * aspect, size)

	var unit_size = size_m / container.size
	return Vector3(unit_size.x, unit_size.y * sqrt(2), unit_size.y * sqrt(2)) * container.stretch_shrink


func zoom_speed() -> float:
	return size / 10.0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	var pos = player.position
	var tex_size = world_tex_size()

	var goal = round(pos / tex_size) * tex_size
	var delta = goal - pos

	position = DEFAULT_POSITION + delta


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("zoom_in"):
		size -= zoom_speed()
		size = max(size, MIN_ZOOM)

	if event.is_action_pressed("zoom_out"):
		size += zoom_speed()
		size = min(size, MAX_ZOOM)
