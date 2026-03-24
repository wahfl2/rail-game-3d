@tool
extends Node3D

class_name InteractableComponent

const INTERACT_FUNC_NAME = &"_interact"


func is_in_game() -> bool:
	return !Engine.is_editor_hint()

#region Tool

func _get_configuration_warnings() -> PackedStringArray:
	var ret: PackedStringArray = []
	if _find_area_children().is_empty():
		ret.append(
			"This node has no Area3D, so it can't be interacted with.\n" +
			"Consider adding an Area3D as a child to define its shape.",
		)

	if _find_interact_children().is_empty():
		ret.append(
			"This node has no interactable children, so interacting with it will do nothing.\n" +
			"Consider adding a child with a function named '" + INTERACT_FUNC_NAME + "'.",
		)

	return ret

#endregion

var _area_children: Array[Area3D] = []
var _interact_children: Array[Node] = []


func _ready() -> void:
	if is_in_game():
		child_entered_tree.connect(_on_child_entered_tree)
		child_exiting_tree.connect(_on_child_exiting_tree)
		_update_children()


func _on_child_entered_tree(_node: Node) -> void:
	_update_children()


func _on_child_exiting_tree(_node: Node) -> void:
	_update_children()


func _update_children() -> void:
	_area_children = _find_area_children()
	_interact_children = _find_interact_children()


func _find_area_children() -> Array[Area3D]:
	var ret: Array[Area3D] = []
	for child in get_children():
		if child is Area3D:
			ret.append(child as Area3D)

	return ret


func _find_interact_children() -> Array[Node]:
	return get_children().filter(func(child: Node): return child.has_method(INTERACT_FUNC_NAME))


func _interacted_with():
	for child in _interact_children:
		child._interact()
