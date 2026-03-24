extends MarginContainer
class_name TopBar


signal dragged(delta: Vector2i)


var dragging = false


func _gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			dragging = true


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and !event.pressed:
			dragging = false
	
	if event is InputEventMouseMotion:
		if dragging:
			dragged.emit(event.screen_relative)
