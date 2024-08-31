extends Node

const MENU = preload("res://scenes/main_menu.tscn")
var menu_ref = null


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Pause"):
		if menu_ref != null:
			menu_ref.queue_free()
			menu_ref = null
		else:
			# Instantiate the menu in the ui viewport
			menu_ref = MENU.instantiate()
			get_tree().root.add_child.call_deferred(menu_ref)
		
	pass
