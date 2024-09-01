extends Node

@onready var gameplay_ui = get_node("/root/Main/GameplayUI")

var in_battle = false
var in_battle_with = ""
var pct_left = 100

func set_battling(name):
	in_battle = true
	in_battle_with = name
	pct_left = 100
	
func not_battling():
	in_battle = false
	in_battle_with = ""
	pct_left = 0
	
func move_camera_back():
	var pos_x = 960
	var pos_y = 544
	var camera: Camera2D = get_node("/root/Main/GameContainer/GameViewport/MainCamera")
	
	camera.zoom = Vector2(1, 1)
	camera.position = Vector2(pos_x, pos_y)

func successful_hit(input):
	var member: Member = get_node("/root/Main/GameContainer/GameViewport/" + in_battle_with)
	var blocked
	
	if input == 0 and member.get_b_position().x == 1:
		print("blocked x")
		blocked = true
	elif input == 1 and member.get_b_position().y == 1:
		print("blocked y")
		blocked = true
	elif input == 2 and member.get_b_position().z == 1:
		print("blocked z")
		blocked = true
		
	if blocked:
		return false
		
	pct_left = pct_left - member.behaviour.reduction_per_hit
	
	print(pct_left)
	
	if pct_left <= 0:
		member.defeated = true
		move_camera_back()
		gameplay_ui.play_hide()
		not_battling()
	
	return true
