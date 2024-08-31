class_name GameSettings extends Resource

@export var volume: float = 0.5:
	set(value):
		volume = value
		emit_changed()
