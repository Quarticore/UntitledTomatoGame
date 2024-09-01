extends Node

var root_path = "/root/Main/GameContainer/GameViewport/"
@onready var Manager: GameManager = get_node("/root/GameManager")
@onready var Member1: Node2D = get_node(root_path + "Member1")
@onready var Member2: Node2D = get_node(root_path + "Member2")
@onready var Member3: Node2D = get_node(root_path + "Member3")
@onready var Camera: Camera2D = get_node(root_path + "MainCamera")

var stage = 0

func _ready():
	hide_all_lights()

func hide_all_lights():
	Member1.hide_light()
	Member2.hide_light()
	Member3.hide_light()

func member_by_stage():
	if stage == 0:
		return Member1
	elif stage == 1:
		return Member2
	
	return Member3
	
func set_stage(i):
	stage = i
	hide_all_lights()
	
	var member = member_by_stage()
	member.get_node("AnimationPlayer").connect("animation_finished", func(_x):
		var player = member.get_node("AnimationPlayer")
		member.show_light()
		
		var signals = player.get_signal_connection_list("animation_finished")
		
		for s in signals:
			s.signal.disconnect(s.callable)
	)

func on_select_any():
	var gameplay_ui = get_node("/root/Main/GameplayUI")
	gameplay_ui.play_show()
	
	hide_all_lights()

#func _on_member_hovered() -> void:
	#Member1.show_light()
	#Member2.hide_light()
	#Member3.hide_light()
#
#func _on_member_2_hovered() -> void:
	#Member2.show_light()
	#Member1.hide_light()
	#Member3.hide_light()
#
#func _on_member_3_hovered() -> void:
	#Member3.show_light()
	#Member2.hide_light()
	#Member1.hide_light()

func _on_member_selected() -> void:
	if Member1.defeated or stage != 0:
		return
	
	Camera.zoom = Vector2(2, 2)
	Camera.global_position = Member1.global_position
	
	Manager.set_battling("Member1")
	
	on_select_any()

func _on_member_2_selected() -> void:
	if Member2.defeated or stage != 1:
		return

	Camera.zoom = Vector2(2, 2)
	Camera.global_position = Member2.global_position
	
	Manager.set_battling("Member2")
	
	on_select_any()

func _on_member_3_selected() -> void:
	if Member3.defeated or stage != 2:
		return

	Camera.zoom = Vector2(2, 2)
	Camera.global_position = Member3.global_position
	
	Manager.set_battling("Member3")
	
	on_select_any()
