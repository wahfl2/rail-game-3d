extends MarginContainer

class_name InventoryUI

@onready var top_bar_container: TopBar = $VBox/TopBarContainer
@onready var h_box: HBoxContainer = $VBox/HBox
@onready var player: Player = %Player
@onready var background_rect: NinePatchRect = $BackgroundRect

@export var screens: Array[BaseScreen]:
	get:
		return screens.duplicate()
	set(value):
		screens = value
		_update_children()
		_update_inventories()


func _ready() -> void:
	close()
	top_bar_container.dragged.connect(_dragged)
	SignalBus.chest_interacted.connect(_on_chest_interacted)


func _input(event: InputEvent) -> void:
	if self.visible and (event.is_action_pressed("inventory") or Input.is_action_pressed("escape")):
		close()
		get_viewport().set_input_as_handled()


func _process(_delta: float) -> void:
	pass


func _on_close_button_pressed() -> void:
	close()


func _dragged(delta: Vector2i) -> void:
	position += Vector2(delta) / viewport_scaling()


func viewport_scaling() -> int:
	var viewport_parent = get_viewport().get_parent()
	if viewport_parent is SubViewportContainer:
		return viewport_parent.stretch_shrink
	else:
		return 1


func _on_chest_interacted(container: ItemContainer) -> void:
	open_with([ContainerScreen._initialize(player.inventory), ContainerScreen._initialize(container)])


func open_with(_screens: Array[BaseScreen]) -> void:
	screens = _screens
	open()


func open() -> void:
	background_rect.reset_size()
	self.visible = true


func close() -> void:
	self.visible = false


func _update_children():
	var invs: Array[BaseScreen] = screens.duplicate()

	for child in h_box.get_children():
		var new: BaseScreen = invs.pop_front()

		if new == null:
			child.queue_free()
			continue

		var old = child as BaseScreen

		if old.identifier() != new.identifier():
			old.add_sibling(new.instantiate())
			old.queue_free()
		else:
			old.clone(new)

	if !invs.is_empty():
		for inv in invs:
			h_box.add_child(inv.instantiate())


func _update_inventories() -> void:
	for child in h_box.get_children():
		var base := child as BaseScreen
		base.update()
