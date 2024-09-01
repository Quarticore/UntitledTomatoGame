class_name Member extends Node

signal hovered
signal selected

@export var behaviour: EnemyPattern
@export var pos_sprites: Array[Texture2D] = []
@export var defeat_sprite: Texture2D
@onready var audio_manager: Node = $"../AudioManager"
@onready var game_manager: GameManager = get_node("/root/GameManager")
@onready var beats_until_change = behaviour.maybe_change_every_x_beats - 1

var position_idx = 0
var defeated = false

func _ready():
	audio_manager.connect("new_beat", on_new_beat)

func _on_area_2d_mouse_entered() -> void:
	hovered.emit()

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	# If clicked emit "selected"
	if event.is_action("Click"):
		selected.emit()

func show_light():
	if !game_manager.in_battle and !defeated:
		$AnimationPlayer.play("show_light")

func hide_light():
	$AnimationPlayer.play("hide_light")

func get_b_position():
	return behaviour.valid_positions[position_idx]
	
func set_b_position(new_idx):
	position_idx = new_idx
	
	if pos_sprites.size() - 1 >= position_idx:
		$Sprite.texture = pos_sprites[position_idx]

func on_new_beat(elapsed):
	# Squash em
	$SquashPlayer.play("squash")
	
	if !game_manager.in_battle or game_manager.in_battle_with != name:
		return
	
	if beats_until_change != 0:
		beats_until_change -= 1
		return
	else:
		beats_until_change = behaviour.maybe_change_every_x_beats - 1

	var rng = RandomNumberGenerator.new()
	var will_change = rng.randi_range(1, behaviour.chance_to_change) == 1
	
	if !will_change:
		return
		
	var arr = behaviour.valid_positions.filter(func(n): return n != get_b_position())
	
	# Pick one
	var new_val = arr[rng.randi_range(0, arr.size() - 1)]
	var new_idx = behaviour.valid_positions.find(new_val)
	
	set_b_position(new_idx)
