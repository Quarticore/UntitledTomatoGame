extends Node

@onready var Player: AudioStreamPlayer = $AudioStreamPlayer
@onready var Output: Label = $Output
var paused_at = 0.0
var bpm = 125.0
var bps = bpm / 60
var offset = 0.2
var last_beat_elapsed = 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# When SPACE is RELEASED, play/pause
	if Input.is_action_just_released("PauseSong_PLEASE_REMOVE"):
		if !Player.playing:
			print("playing")
			Player.play(paused_at)
		else:
			print("pausing")
			paused_at = Player.get_playback_position()
			Player.stop()
			
	if !Player.playing:
		return
	
	var beats_elapsed: float = (Player.get_playback_position() / (1 / bps)) + offset
	
	# Round to whole number, see if different
	if round(beats_elapsed) != round(last_beat_elapsed):
		push_o_on_beat()
	
	last_beat_elapsed = beats_elapsed
	
	pass

func push_o_on_beat():
	Output.text = Output.text + "O"
