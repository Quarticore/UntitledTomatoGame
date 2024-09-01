class_name EnemyPattern extends Resource

## Chance for the enemy to change positions
@export var chance_to_change: float = 1.0:
	set(val):
		chance_to_change = val
		emit_changed()
@export var valid_positions = [Vector3(0, 0, 1), Vector3(0, 1, 0), Vector3(1, 0, 0)]:
	set(val):
		valid_positions = val
		emit_changed()
@export var maybe_change_every_x_beats: int = 1:
	set(val):
		maybe_change_every_x_beats = val
		emit_changed()
@export var reduction_per_hit: int = 5:
	set(val):
		reduction_per_hit = val
		emit_changed()
