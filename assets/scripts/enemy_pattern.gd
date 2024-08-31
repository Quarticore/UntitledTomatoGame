class_name EnemyPattern extends Resource

## Chance for the enemy to change positions
@export var chance_to_change: float = 1.0:
	set(val):
		chance_to_change = val
		emit_changed()
@export var valid_positions = [0x00000001,0x00000010,0x00000100]:
	set(val):
		valid_positions = val
		emit_changed()
@export var maybe_change_every_x_beats: int = 1:
	set(val):
		maybe_change_every_x_beats = val
		emit_changed()
