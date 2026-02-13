extends CharacterBody3D


const SPEED = 10.0
const SPEED_NORMALIZATION = sqrt(2)


@onready var model: Node3D = $Model
@onready var animation_player: AnimationPlayer = $Model/AnimationPlayer


var prev_walking = false


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	var input_dir := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED * SPEED_NORMALIZATION
		
		var angle = wrapf(atan2(-direction.x, -direction.z) - model.rotation.y, -PI, PI)
		model.rotation.y += angle / 4
		
		animation_player.play("walk", 0.4, 2.0)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED * SPEED_NORMALIZATION)
		
		animation_player.play("idle", 1.0)

	move_and_slide()


func _on_ready() -> void:
	pass
