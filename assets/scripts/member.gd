extends Node

signal hovered
signal selected

func _on_area_2d_mouse_entered() -> void:
	hovered.emit()


func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	# If clicked emit "selected"
	if event.is_action("Click"):
		selected.emit()
