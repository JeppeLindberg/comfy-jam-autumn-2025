extends Node2D



var lifetime = 0.0
var base_pos

func _ready() -> void:
	base_pos = position

func _process(delta: float) -> void:
	lifetime += delta

	var i =  (int(floor(lifetime * 2.0)) % 2) * 2.0 - 1.0
	position = base_pos + Vector2.RIGHT * i
