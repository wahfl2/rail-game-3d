extends HFlowContainer

class_name InventoryUISlots

const SLOT: PackedScene = preload("uid://6xpwuimrva5l")
@onready var container: ContainerScreen = $"../.."


func container_display() -> ItemContainer:
	if container.display_container != null:
		return container.display_container
	else:
		return ItemContainer.new().initialize(ContainerTypes.DUMMY, ItemContainer.OwnerType.CONTAINER)


func _ready() -> void:
	pass # Replace with function body.


func update() -> void:
	update_slot_count()
	update_slots_display()


func update_slot_count() -> void:
	var child_count = self.get_child_count()
	var slots_count = container_display().container_type.slots_count

	if child_count == slots_count:
		return

	if child_count > slots_count:
		var slot_number = 0
		for slot in self.get_children():
			if slot_number >= slots_count:
				slot.queue_free()
			slot_number += 1

	elif child_count < slots_count:
		for i in range(slots_count - child_count):
			var node = SLOT.instantiate()
			self.add_child(node)


func update_slots_display() -> void:
	var slot_number = 0
	var container_slots = container_display().slots

	for slot in self.get_children():
		if slot_number >= container_slots.size():
			push_warning("Container had less slots than ContainerType")
			break

		if slot is InventorySlot:
			slot.slot_index = slot_number
			slot.item_stack = container_slots[slot_number]
			slot_number += 1

	if slot_number < container_slots.size():
		push_warning("Container had more slots than ContainerType")
