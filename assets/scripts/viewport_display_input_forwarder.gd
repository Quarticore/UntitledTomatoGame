extends Sprite2D

@onready var ui_viewport: SubViewport = get_node("/root/Main/UIViewport")

func _ready():
	ui_viewport.set_process_unhandled_input(true)

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	# Pass to viewport
	if event.is_action_pressed("Click"):
		var mevent = event.duplicate()
		ui_viewport.push_unhandled_input(mevent)
