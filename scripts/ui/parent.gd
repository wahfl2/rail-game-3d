extends Node

class_name UIParent

signal mouse_entered
signal mouse_exited

var mouse_inside = false


func _ready() -> void:
	for child: Control in get_children().filter(func(c): return c is Control):
		child.mouse_entered.connect(_mouse_entered)
		child.mouse_exited.connect(_mouse_exited)


func _mouse_entered() -> void:
	mouse_inside = true
	mouse_entered.emit()


func _mouse_exited() -> void:
	mouse_inside = false
	mouse_exited.emit()
