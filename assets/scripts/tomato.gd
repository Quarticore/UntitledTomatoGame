extends PathFollow2D


const MAX_SIZE: Vector2 = Vector2(6.0, 6.0)
const MIN_SIZE: Vector2 = Vector2(0.5, 0.5)

@onready var sprite: Sprite2D = $Sprite2D
@onready var fade_timer: Timer = $FadeTimer
@onready var travel_timer: Timer = $TravelTimer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_parent()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	progress_ratio = inverse_lerp(travel_timer.wait_time, 0.0, travel_timer.time_left)
	
	scale = MAX_SIZE.lerp(MIN_SIZE, progress_ratio)
	
	if not fade_timer.is_stopped():
		modulate.a = inverse_lerp(0.0, fade_timer.wait_time, fade_timer.time_left)
	
	if progress_ratio == 1.0 and fade_timer.is_stopped():
		hit()


func hit() -> void:
	fade_timer.start()
	

func _on_fade_timer_timeout() -> void:
	queue_free()
