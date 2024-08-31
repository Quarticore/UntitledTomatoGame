extends Camera2D

@onready var tex: TextureRect = $ViewportTextureRect

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	tex.set_position(position, true)
	tex.scale = Vector2(1, 1) / zoom
	pass
