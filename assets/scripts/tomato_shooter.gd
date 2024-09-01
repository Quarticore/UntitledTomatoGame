extends Node2D


const TOMATO_SCENE: PackedScene = preload("res://scenes/tomato.tscn")
const TOMATO: Script = preload("res://assets/scripts/tomato.gd")
const METRONOME: Script = preload("res://assets/scripts/metronome.gd")


@export var audio_manager: METRONOME

@onready var left_spawn: Path2D = $TomatoSpawnLeft
@onready var middle_spawn: Path2D = $TomatoSpawnMiddle
@onready var right_spawn: Path2D = $TomatoSpawnRight
@onready var crosshair: Sprite2D = $Crosshair


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("InputLeft"):
		spawn_at_path(TOMATO_SCENE.instantiate(), left_spawn)
	
	if Input.is_action_just_pressed("InputMiddle"):
		spawn_at_path(TOMATO_SCENE.instantiate(), middle_spawn)
	
	if Input.is_action_just_pressed("InputRight"):
		spawn_at_path(TOMATO_SCENE.instantiate(), right_spawn)



func spawn_at_path(instance: TOMATO, path: Path2D) -> void:
	path.add_child(instance)
