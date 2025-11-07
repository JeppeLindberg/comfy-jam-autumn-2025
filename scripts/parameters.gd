extends Node3D


@onready var main = get_node('/root/main')


@export_range(-1.0, 1.0) var sun_meter = 0.0
@export_range(-1.0, 1.0) var wind_meter = 0.0
@export_range(-1.0, 1.0) var rain_meter = 0.0

@export var sun_ui_parameter: Control
@export var wind_ui_parameter: Control
@export var rain_ui_parameter: Control

@export var sun_amount = 1.0
@export var wind_amount = 1.0
@export var rain_amount = 1.0


@export var sun_amount_day_curve: Curve



func _process(_delta: float) -> void:
	sun_ui_parameter.meter = sun_meter
	wind_ui_parameter.meter = wind_meter
	rain_ui_parameter.meter = rain_meter

	sun_amount = sun_meter * sun_amount_day_curve.sample(main.hour_of_day()) * 1.5
	wind_amount = wind_meter
	rain_amount = rain_meter
