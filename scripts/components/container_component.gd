extends Node

class_name ContainerComponent

@export var container: ItemContainer

func _interact():
	SignalBus.chest_interacted.emit(container)
