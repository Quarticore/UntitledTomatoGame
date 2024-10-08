class_name AudioManager extends Node

signal new_beat
signal rhythm_input
signal combo_break

const LOOP_TRACK = preload("res://assets/audio/Macrolisk_LOOP_ALL.mp3")

@onready var Player: AudioStreamPlayer = $Player
@onready var settings: GameSettings = preload("res://resources/settings_profile.tres")
@export var beat_linear: float = 0.0
var input_within = 0.3
var input_offset = -0.3
var bpm = 125.0
var bps = bpm / 60
var offset = 0.2
var last_beat_elapsed = 0.0
var combo = 0
var last_input_beat = -1

func recalculate(new_bpm):
	bpm = new_bpm
	bps = new_bpm / 60

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	settings.changed.connect(_on_settings_changed)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !Player.playing:
		do_switch_track()
		return
	
	var beats_elapsed: float = (Player.get_playback_position() / (1 / bps)) + offset
	
	var linear_offset = 1.0 + input_offset
	beat_linear = (beats_elapsed + linear_offset) - floor(beats_elapsed + linear_offset)
	
	check_input(beats_elapsed + input_offset)
	
	# Round to whole number, see if different
	if round(beats_elapsed) != round(last_beat_elapsed):
		new_beat.emit(beats_elapsed)
	
	last_beat_elapsed = beats_elapsed
	
	pass
	
func check_input(beats_elapsed):
	var input = -1
	
	if Input.is_action_just_pressed("InputLeft"):
		input = 0
	elif Input.is_action_just_pressed("InputMiddle"):
		input = 1
	elif Input.is_action_just_pressed("InputRight"):
		input = 2
	else:
		# No input
		return
	
	
	var beat_whole = round(beats_elapsed)
	var difference = abs(beats_elapsed - beat_whole)
	
	if last_input_beat == beat_whole:
		# no spamming!
		return
	
	last_input_beat = beat_whole
	
	if (difference <= input_within):
		# We hit! Show accuracy
		var complement = input_within - difference
		var as_percentage = (complement / input_within) * 100
		
		combo += 1
		rhythm_input.emit(as_percentage, combo, input)
		return
	
	combo = 0
	rhythm_input.emit(0.0, combo, input)
	combo_break.emit()


func _on_settings_changed() -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), linear_to_db(settings.volume))

func do_switch_track() -> void:
	# Set the loop track
	Player.stream = LOOP_TRACK
	Player.play(0.0)
	pass
