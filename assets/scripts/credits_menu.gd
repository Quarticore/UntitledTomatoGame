extends Menu

var main_menu: PackedScene = load("res://scenes/main_menu.tscn")


func _on_back_button_pressed() -> void:
	add_to_scene(main_menu.instantiate())
	queue_free()
