extends Sprite2D

const SPEED: float = 1000.0
const MAX_SIZE: Vector2 = Vector2(1.0, 1.0)
const MIN_SIZE: Vector2 = Vector2(0.5, 0.5)

var start_pos: Vector2 = Vector2.ONE:
	set(value):
		position = value
		start_pos = value
var target: Vector2 = Vector2.ZERO

@onready var timer: Timer = $Timer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position = position.move_toward(target, SPEED * delta)
	
	scale = MAX_SIZE.lerp(MIN_SIZE, inverse_lerp(start_pos.distance_to(target), 0.0, position.distance_to(target)))
	
	if not timer.is_stopped():
		modulate.a = inverse_lerp(0.0, timer.wait_time, timer.time_left)
	
	if position == target and timer.is_stopped():
		hit()


func hit() -> void:
	timer.start()
	

func _on_timer_timeout() -> void:
	queue_free()
