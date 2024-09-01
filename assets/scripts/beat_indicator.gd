extends Node2D


const METRONOME: Script = preload("res://assets/scripts/metronome.gd")
const MIN_SIZE: float = 3
const MAX_SIZE: float = 4
const EDGE_POS := Vector2(960, 0)

@export var audio_manager: METRONOME

@onready var c_indicator: Sprite2D = $CentreIndicator
@onready var l_indicator: Sprite2D = $LeftIndicator
@onready var r_indicator: Sprite2D = $RightIndicator

var beat_linear_prev: float = 0.0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var beat_linear = audio_manager.beat_linear
	
	if beat_linear_prev > beat_linear:
		# Reset to original values
		c_indicator.scale = Vector2(MAX_SIZE, MAX_SIZE)
		l_indicator.position = -EDGE_POS
		r_indicator.position = EDGE_POS
	else:
		# Move in time with beat
		c_indicator.scale = Vector2(MAX_SIZE, MAX_SIZE).lerp(Vector2(MIN_SIZE, MIN_SIZE), beat_linear)
		l_indicator.position = -EDGE_POS.lerp(Vector2(0, 0), beat_linear)
		r_indicator.position = EDGE_POS.lerp(Vector2(0, 0), beat_linear)
	
	# Update with current frame's value
	beat_linear_prev = beat_linear
