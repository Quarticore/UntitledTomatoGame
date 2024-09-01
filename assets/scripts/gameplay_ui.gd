extends Node

const HIT_QUALITY_ITEM = preload("res://scenes/hit_quality_item.tscn")
const HIT_PERFECT = preload("res://assets/images/input_perfect.png")

func play_show():
	$AnimationPlayer.play("fade_in")

func play_hide():
	$AnimationPlayer.play("fade_out")

func _on_audio_manager_rhythm_input(pct, combo, input) -> void:
	if pct == 0.0:
		print("Miss")
	elif pct > 65:
		print("Perfect")
	elif pct > 35:
		print("Great")
	else:
		print("Okay")
	
	print(pct)
	
	var inst = HIT_QUALITY_ITEM.instantiate()
	inst.texture = HIT_PERFECT
	inst.scale = Vector2(0.3, 0.3)
	inst.rotation_degrees = 10.0
	
	$HitQualityContainer.add_child(inst)
	
