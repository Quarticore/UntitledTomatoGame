extends Node

@onready var Player: AudioStreamPlayer = $AudioStreamPlayer
@onready var Accuracy: Label = $Accuracy
var input_within = 0.2
var input_offset = -0.4
var bpm = 125.0
var bps = bpm / 60
var offset = 0.2
var last_beat_elapsed = 0.0
var combo = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !Player.playing:
		return
	
	var beats_elapsed: float = (Player.get_playback_position() / (1 / bps)) + offset
	
	check_input(beats_elapsed + input_offset)
	
	# Round to whole number, see if different
	if round(beats_elapsed) != round(last_beat_elapsed):
		emit_signal("new_beat", beats_elapsed)
	
	last_beat_elapsed = beats_elapsed
	
	pass
	
func check_input(beats_elapsed):
	if !Input.is_action_just_pressed("Input_PLEASE_REMOVE"):
		return
	
	var beat_whole = round(beats_elapsed)
	var difference = abs(beats_elapsed - beat_whole)
	
	if (difference <= input_within):
		# We hit! Show accuracy
		var complement = input_within - difference
		var as_percentage = (complement / input_within) * 100
		Accuracy.text = str(as_percentage) + "%\ncombo: " + str(combo)
		
		combo += 1
		emit_signal("rhythm_input", as_percentage, combo)
		return
	
	Accuracy.text = "0%\ncombo: 0"
	
	combo = 0
	emit_signal("rhythm_input", 0.0, combo)
	emit_signal("combo_break")
