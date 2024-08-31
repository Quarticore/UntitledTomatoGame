extends Node

@onready var Light: Sprite2D = get_node("/root/Main/Light")
@onready var Member1: Node2D = get_node("/root/Main/Member")
@onready var Member2: Node2D = get_node("/root/Main/Member2")
@onready var Member3: Node2D = get_node("/root/Main/Member3")
@onready var Camera: Camera2D = get_node("/root/Main/MainCamera")

func on_select_any():
	var gameplay_ui = get_node("/root/Main/GameplayUI")
	# gameplay_ui.play_show()

func _on_member_hovered() -> void:
	Light.global_position.x = Member1.global_position.x

func _on_member_2_hovered() -> void:
	Light.global_position.x = Member2.global_position.x

func _on_member_3_hovered() -> void:
	Light.global_position.x = Member3.global_position.x

func _on_member_selected() -> void:
	Camera.zoom = Vector2(2, 2)
	Camera.global_position = Member1.global_position
	on_select_any()

func _on_member_2_selected() -> void:
	Camera.zoom = Vector2(2, 2)
	Camera.global_position = Member2.global_position
	on_select_any()

func _on_member_3_selected() -> void:
	Camera.zoom = Vector2(2, 2)
	Camera.global_position = Member3.global_position
	on_select_any()
