extends Camera2D

@onready var tex: Sprite2D = $ViewportTextureRect

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	tex.scale = Vector2(1, 1) / zoom
	pass
