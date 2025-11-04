extends Sprite2D



var lifetime = 0.0


func _process(delta: float) -> void:
	lifetime += delta

	scale = Vector2.ONE * (1.0-inverse_lerp(-1.0, 0.0, cos(lifetime*10.0)*0.8 + cos(lifetime*14.0)*0.2)*0.2)
