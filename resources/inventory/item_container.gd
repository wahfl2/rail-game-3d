extends Resource

class_name ItemContainer

enum OwnerType {
	CONTAINER,
	PLAYER
}

@export var container_type: ContainerType
@export var owner: OwnerType
@export var slots: Array[ItemStack]:
	get:
		if not container_type == null:
			if slots == null:
				slots = []

			if not slots.size() == container_type.slots_count:
				slots.resize(self.container_type.slots_count)

		return slots


func initialize(_container_type: ContainerType, _owner: OwnerType) -> ItemContainer:
	self.container_type = _container_type
	self.owner = _owner

	self.slots = []
	self.slots.resize(_container_type.slots_count)

	return self
