extends Node2D


const TOMATO_SCENE: PackedScene = preload("res://scenes/tomato.tscn")
const TOMATO: Script = preload("res://assets/scripts/tomato.gd")
const METRONOME: Script = preload("res://assets/scripts/metronome.gd")


@export var audio_manager: METRONOME

@onready var game_manager: GameManager = get_node("/root/GameManager")
@onready var left_spawn: Path2D = $TomatoSpawnLeft
@onready var middle_spawn: Path2D = $TomatoSpawnMiddle
@onready var right_spawn: Path2D = $TomatoSpawnRight
@onready var crosshair: Sprite2D = $Crosshair


func _ready() -> void:
	audio_manager.rhythm_input.connect(parse_input)


func spawn_at_path(instance: TOMATO, path: Path2D) -> void:
	path.add_child(instance)


func parse_input(percentage: float, combo: int, input: int) -> void:
	if percentage == 0.0:
		return
	
	match input:
		0:
			spawn_at_path(TOMATO_SCENE.instantiate(), left_spawn)
		1:
			spawn_at_path(TOMATO_SCENE.instantiate(), middle_spawn)
		2:
			spawn_at_path(TOMATO_SCENE.instantiate(), right_spawn)
			
	game_manager.successful_hit(input)
