class_name Menu extends Control


@onready var ui_viewport: SubViewport = %UIViewport


func add_to_scene(scene: Node) -> void:
	if ui_viewport:
		ui_viewport.add_child(scene)
	else:
		get_tree().root.add_child(scene)
