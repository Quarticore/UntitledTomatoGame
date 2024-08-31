extends Node

func show():
	$AnimationPlayer.play("fade_in")

func hide():
	$AnimationPlayer.play("fade_out")

func _on_audio_manager_rhythm_input(pct, combo, input) -> void:
	if pct == 0.0:
		$HitQualityIndicator.text = "Miss"
	elif pct > 65:
		$HitQualityIndicator.text = "Perfect!"
	elif pct > 35:
		$HitQualityIndicator.text = "Great!"
	else:
		$HitQualityIndicator.text = "Okay..."
		
	$HitQualityIndicator.text = $HitQualityIndicator.text + " (" + str(pct) + "%)"
