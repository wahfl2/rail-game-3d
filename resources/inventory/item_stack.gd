extends Resource

class_name ItemStack

@export var item_type: ItemType
@export var count: int


func initialize(_item_type: ItemType, _count: int) -> ItemStack:
	self.item_type = _item_type
	self.count = _count

	return self
