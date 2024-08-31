extends Control

var main_menu: PackedScene = load("res://scenes/main_menu.tscn")


func _on_back_button_pressed() -> void:
	get_tree().root.add_child(main_menu.instantiate())
	queue_free()
