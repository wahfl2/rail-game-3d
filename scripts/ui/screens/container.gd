extends BaseScreen

class_name ContainerScreen

@onready var slots: InventoryUISlots = $ScrollContainer/Slots

@export var display_container: ItemContainer


static func _initialize(container: ItemContainer) -> ContainerScreen:
	var ret = ContainerScreen.new()
	ret.display_container = container
	return ret


func clone(new: BaseScreen) -> void:
	var new_container := new as ContainerScreen
	display_container = new_container.display_container


func update() -> void:
	slots.update()
	
	for child in slots.get_children():
		var slot = child as InventorySlot
		slot.interact.connect(_on_slot_interact)


func instantiate() -> BaseScreen:
	var ret := UIRegistry.CONTAINER.instantiate() as ContainerScreen
	ret.display_container = self.display_container

	return ret


func identifier() -> StringName:
	return "container"


func _on_slot_interact(slot: InventorySlot) -> void:
	if slot.is_item_stack_in_cursor:
		slot.is_item_stack_in_cursor = false
		return

	var item := display_container.slots[slot.index]
	
	if item != null:
		slot.is_item_stack_in_cursor = true
		SignalBus.slot_clicked.emit(display_container, slot)
