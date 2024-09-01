extends Node

@onready var gameplay_ui = get_node("/root/Main/GameplayUI")

var in_battle = false
var in_battle_with = ""
var in_double_time = false
var pct_left = 100

func _process(_delta):
	# Special consideration for Member3
	if in_battle_with != "Member3":
		return
		
	if pct_left < 75 and !in_double_time:
		trigger_double_time() 

func set_battling(name):
	in_battle = true
	in_battle_with = name
	pct_left = 100
	
func not_battling():
	in_battle = false
	in_battle_with = ""
	pct_left = 0
	
func trigger_double_time():
	if in_double_time:
		return
		
	var audio_manager: AudioManager = get_node("/root/Main/GameContainer/GameViewport/AudioManager")
	audio_manager.recalculate(audio_manager.bpm * 2)
	audio_manager.input_within = 0.2
	audio_manager.input_offset = -0.4
	
	in_double_time = true
	
func exit_double_time():
	if !in_double_time:
		return
		
	var audio_manager: AudioManager = get_node("/root/Main/GameContainer/GameViewport/AudioManager")
	audio_manager.recalculate(audio_manager.bpm / 2)
	audio_manager.input_within = 0.3
	audio_manager.input_offset = -0.3
	
	in_double_time = false
	
func move_camera_back():
	var pos_x = 960
	var pos_y = 544
	var camera: Camera2D = get_node("/root/Main/GameContainer/GameViewport/MainCamera")
	var defeat_label = get_node("/root/Main/DefeatLabel/AnimationPlayer")
	var member = get_node("/root/Main/GameContainer/GameViewport/" + in_battle_with)
	
	camera.zoom = Vector2(1, 1)
	camera.position = Vector2(pos_x, pos_y)
	
	defeat_label.play("fade_in")
	
	if member.defeat_sprite != null:
		var sprite = get_node("/root/Main/GameContainer/GameViewport/" + in_battle_with + "/Sprite")
		sprite.texture = member.defeat_sprite

func successful_hit(input):
	if !in_battle:
		return
	
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
