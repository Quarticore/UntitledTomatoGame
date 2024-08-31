extends Sprite2D

const SPEED: float = 1000.0

var target: Vector2 = Vector2.ZERO

@onready var timer: Timer = $Timer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position = position.move_toward(target, SPEED * delta)
	
	
	if not timer.is_stopped():
		print(timer.time_left)
		modulate.a = inverse_lerp(0.0, timer.wait_time, timer.time_left)
	
	if position == target and timer.is_stopped():
		hit()


func hit() -> void:
	timer.start()
	

func _on_timer_timeout() -> void:
	queue_free()
