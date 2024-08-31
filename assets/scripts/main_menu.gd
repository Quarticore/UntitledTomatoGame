extends Control

var credits: PackedScene = load("res://scenes/credits_menu.tscn")
var options: PackedScene = load("res://scenes/options_menu.tscn")


func _on_play_button_pressed() -> void:
	queue_free()


func _on_credits_button_pressed() -> void:
	get_tree().root.add_child(credits.instantiate())
	queue_free()


func _on_options_button_pressed() -> void:
	get_tree().root.add_child(options.instantiate())
	queue_free()
