extends Control

class_name InventorySlot

signal interact(slot: InventorySlot)

const SLOT_IN_CURSOR_TEXTURE = preload("uid://de4dfhatfhcir")

@onready var count: Label = $Margin/Count
@onready var item_icon: TextureRect = $Margin/ItemIcon

@export var index: int
@export var item_stack: ItemStack:
	set(value):
		if value:
			count.text = str(value.count)
			item_icon.texture = value.item_type.icon
		else:
			count.text = ""
			item_icon.texture = null

		item_stack = value


@export var is_item_stack_in_cursor: bool:
	set(value):
		is_item_stack_in_cursor = value

		if is_item_stack_in_cursor:
			count.text = ""
			item_icon.texture = SLOT_IN_CURSOR_TEXTURE
		else:
			self.item_stack = item_stack


func _gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		interact.emit(self)


func _ready() -> void:
	item_stack = null
