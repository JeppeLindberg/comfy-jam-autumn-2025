extends Node3D


@export_range(-1.0, 1.0) var sun = 0.0

@export var sun_ui_parameter: Control



func _process(_delta: float) -> void:
	sun_ui_parameter.meter = sun


