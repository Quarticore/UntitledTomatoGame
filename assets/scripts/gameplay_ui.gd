extends Node

const HIT_QUALITY_ITEM = preload("res://scenes/hit_quality_item.tscn")
const HIT_PERFECT = preload("res://assets/images/input_perfect_px.png")
const HIT_GREAT = preload("res://assets/images/input_great_px.png")
const HIT_OKAY = preload("res://assets/images/input_okay_px.png")
const HIT_MISS = preload("res://assets/images/input_miss_px.png")

@onready var game_manager: GameManager = get_node("/root/GameManager")

func _process(delta):
	var pct = game_manager.pct_left
	$HealthBar.value = pct

func play_show():
	$AnimationPlayer.play("fade_in")

func play_hide():
	$AnimationPlayer.play("fade_out")

func _on_audio_manager_rhythm_input(pct, combo, input) -> void:
	var hit_asset
	
	if pct == 0.0:
		print("Miss")
		hit_asset = HIT_MISS
	elif pct > 65:
		print("Perfect")
		hit_asset = HIT_PERFECT
	elif pct > 35:
		print("Great")
		hit_asset = HIT_GREAT
	else:
		print("Okay")
		hit_asset = HIT_OKAY
	
	print(pct)
	
	var rng = RandomNumberGenerator.new()
	
	var inst = HIT_QUALITY_ITEM.instantiate()
	inst.texture = hit_asset
	inst.scale = Vector2(0.7, 0.7)
	inst.rotation_degrees = rng.randi_range(5, 10)
	
	$HitQualityContainer.add_child(inst)
