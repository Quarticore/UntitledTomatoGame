extends Menu


var credits: PackedScene = load("res://scenes/credits_menu.tscn")
var options: PackedScene = load("res://scenes/options_menu.tscn")


func _on_play_button_pressed() -> void:
	get_tree().paused = false
	queue_free()


func _on_credits_button_pressed() -> void:
	add_to_scene(credits.instantiate())
	queue_free()


func _on_options_button_pressed() -> void:
	add_to_scene(options.instantiate())
	queue_free()
