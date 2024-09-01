extends Node

const MENU = preload("res://scenes/main_menu.tscn")
var menu_ref = null


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Pause"):
		if menu_ref != null:
			menu_ref.queue_free()
			menu_ref = null
			get_tree().paused = false
		else:
			# Instantiate the menu in the ui viewport
			menu_ref = MENU.instantiate()
			get_tree().root.add_child.call_deferred(menu_ref)
			menu_ref.process_mode = Node.PROCESS_MODE_ALWAYS
			get_tree().paused = true
