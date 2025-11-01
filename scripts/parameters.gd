extends Node3D


@export_range(-1.0, 1.0) var sun = 0.0
@export_range(-1.0, 1.0) var wind = 0.0
@export_range(-1.0, 1.0) var water = 0.0

@export var sun_ui_parameter: Control
@export var wind_ui_parameter: Control
@export var water_ui_parameter: Control



func _process(_delta: float) -> void:
	sun_ui_parameter.meter = sun
	wind_ui_parameter.meter = wind
	water_ui_parameter.meter = water


