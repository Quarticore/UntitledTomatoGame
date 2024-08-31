extends Node

@onready var Light: Sprite2D = get_tree().root.get_node("Main/Light")
@onready var Member1: Node2D = get_tree().root.get_node("Main/Member")
@onready var Member2: Node2D = get_tree().root.get_node("Main/Member2")
@onready var Member3: Node2D = get_tree().root.get_node("Main/Member3")

func _on_member_hovered() -> void:
	Light.global_position.x = Member1.global_position.x

func _on_member_2_hovered() -> void:
	Light.global_position.x = Member2.global_position.x

func _on_member_3_hovered() -> void:
	Light.global_position.x = Member3.global_position.x
