extends Node

signal hovered

func _on_area_2d_mouse_entered() -> void:
	hovered.emit()
