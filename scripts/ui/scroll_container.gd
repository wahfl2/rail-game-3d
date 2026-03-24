extends ScrollContainer

@export var maximum_height: float = 500
@onready var slots: InventoryUISlots = $Slots


func _ready() -> void:
	slots.resized.connect(_on_slots_resized)


func _on_slots_resized() -> void:
	if !is_node_ready():
		return

	if slots.size.y < maximum_height:
		custom_minimum_size.y = slots.size.y
	else:
		custom_minimum_size.y = maximum_height
