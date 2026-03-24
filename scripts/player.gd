extends CharacterBody3D

class_name Player

@export var inventory: ItemContainer

const SPEED = 10.0
const SPEED_NORMALIZATION = sqrt(2)

@onready var model: Node3D = $Model
@onready var animation_player: AnimationPlayer = $Model/AnimationPlayer
@onready var inventory_ui: InventoryUI = %UI/Inventory

var prev_walking = false


func _ready() -> void:
	pass


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("inventory") and not inventory_ui.visible:
		inventory_ui.open_with([ContainerScreen._initialize(inventory)])
		get_viewport().set_input_as_handled()


func _process(_delta: float) -> void:
	pass


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
