extends Menu


@export var settings: GameSettings

@onready var vol_slider: HSlider = $GridContainer/VolumeSlider
@onready var vol_value: Label = $GridContainer/VolumeValue

var main_menu: PackedScene = load("res://scenes/main_menu.tscn")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	settings.changed.connect(_on_settings_changed)


func _on_settings_changed() -> void:
	vol_value.text = "%.2f" % settings.volume


func _on_volume_slider_value_changed(value: float) -> void:
	settings.volume = value


func _on_back_button_pressed() -> void:
	add_to_scene(main_menu.instantiate())
	queue_free()
