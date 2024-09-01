extends Sprite2D

const SPEED: float = 1000.0
const MAX_SIZE: Vector2 = Vector2(1.0, 1.0)
const MIN_SIZE: Vector2 = Vector2(0.5, 0.5)

var start_pos: Vector2 = Vector2.ONE:
	set(value):
		position = value
		start_pos = value
var target: Vector2 = Vector2.ZERO

@onready var fade_timer: Timer = $FadeTimer
@onready var travel_timer: Timer = $TravelTimer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position = start_pos.lerp(target, inverse_lerp(travel_timer.wait_time, 0.0, travel_timer.time_left))
	print(position)
	
	scale = MAX_SIZE.lerp(MIN_SIZE, inverse_lerp(start_pos.distance_to(target), 0.0, position.distance_to(target)))
	
	if not fade_timer.is_stopped():
		modulate.a = inverse_lerp(0.0, fade_timer.wait_time, fade_timer.time_left)
	
	if position == target and fade_timer.is_stopped():
		hit()


func hit() -> void:
	fade_timer.start()
	

func _on_fade_timer_timeout() -> void:
	queue_free()
