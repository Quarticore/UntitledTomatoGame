extends PathFollow2D


const MAX_SIZE: Vector2 = Vector2(6.0, 6.0)
const MIN_SIZE: Vector2 = Vector2(0.5, 0.5)

@onready var sprite: Sprite2D = $Sprite2D
@onready var fade_timer: Timer = $FadeTimer
@onready var travel_timer: Timer = $TravelTimer

var rot_speed: float = randf_range(600, 900)


func _ready() -> void:
	rotation_degrees = randf_range(0, 360)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Side dependent rotation direction
	if global_position.x < 960:
		rotation_degrees += rot_speed * delta
	else:
		rotation_degrees += -rot_speed * delta
	
	# Moves the tomato along the path according to the travel_timeer
	progress_ratio = inverse_lerp(travel_timer.wait_time, 0.0, travel_timer.time_left)
	
	# Scale the tomato down as it progresses along the path
	scale = MAX_SIZE.lerp(MIN_SIZE, progress_ratio)
	
	# Fade out after reaching the end of the path
	if not fade_timer.is_stopped():
		modulate.a = inverse_lerp(0.0, fade_timer.wait_time, fade_timer.time_left)
	
	# Trigger the hit
	if progress_ratio == 1.0 and fade_timer.is_stopped():
		hit()


func hit() -> void:
	fade_timer.start()


func _on_fade_timer_timeout() -> void:
	queue_free()
