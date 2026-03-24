extends SubViewportContainer

func _on_resized() -> void:
	stretch_shrink = max(1, round(size.y / 720))
