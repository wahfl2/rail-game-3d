extends Node

class_name Registries

const _CONTAINER_TYPES_REGISTRY := preload("uid://cgmbiaqwr3sd8")
const _ITEM_TYPES_REGISTRY := preload("uid://bgd8s7uisaxcj")
const _MESHES_REGISTRY = preload("uid://eyq04qkmhd6o")

static var container_types := _load_container_types():
	set = _noop

static var item_types := _load_item_types():
	set = _noop

static var meshes := _load_meshes():
	set = _noop


func _noop(_value) -> void:
	assert(false, "This should NEVER be set bruh")
	pass


static func _load_container_types() -> Dictionary[String, ContainerType]:
	var untyped := _CONTAINER_TYPES_REGISTRY.load_all_blocking("ContainerType")

	var ret: Dictionary[String, ContainerType] = { }
	for key in untyped:
		var value := untyped[key] as ContainerType
		ret[key] = value

	return ret


static func _load_item_types() -> Dictionary[String, ItemType]:
	var untyped := _ITEM_TYPES_REGISTRY.load_all_blocking("ItemType")

	var ret: Dictionary[String, ItemType] = { }
	for key in untyped:
		var value := untyped[key] as ItemType
		ret[key] = value

	return ret


static func _load_meshes() -> Dictionary[String, Mesh]:
	var untyped := _MESHES_REGISTRY.load_all_blocking("Mesh")

	var ret: Dictionary[String, Mesh] = { }
	for key in untyped:
		var value := untyped[key] as Mesh
		ret[key] = value

	return ret
