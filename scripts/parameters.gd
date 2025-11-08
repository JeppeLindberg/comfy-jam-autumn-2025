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

var positive = ''
var negative = ''

@export var parameter_adjust_secs_for_full_meter = 60.0
@export var secs_between_each_parameter_reroll = 33.0
var time_since_last_reroll = 0.0


func _ready() -> void:
	set_positive_negative()

func _process(delta: float) -> void:

	var speed = 1.0 / parameter_adjust_secs_for_full_meter
	if main.time_dialation != 0.0:
		time_since_last_reroll += delta
		if positive == 'sun':
			sun_meter += speed * delta
		if positive == 'wind':
			wind_meter += speed * delta
		if positive == 'rain':
			rain_meter += speed * delta
		if negative == 'sun':
			sun_meter -= speed * delta
		if negative == 'wind':
			wind_meter -= speed * delta
		if negative == 'rain':
			rain_meter -= speed * delta

	if ((sun_meter != clampf(sun_meter, -1.0, 1.0)) or (wind_meter != clampf(wind_meter, -1.0, 1.0)) or (rain_meter != clampf(rain_meter, -1.0, 1.0))) or \
		(time_since_last_reroll > secs_between_each_parameter_reroll):
		set_positive_negative()

	sun_meter = clampf(sun_meter, -1.0, 1.0)
	wind_meter = clampf(wind_meter, -1.0, 1.0)
	rain_meter = clampf(rain_meter, -1.0, 1.0)

	sun_ui_parameter.meter = sun_meter
	wind_ui_parameter.meter = wind_meter
	rain_ui_parameter.meter = rain_meter

	sun_amount = sun_meter * sun_amount_day_curve.sample(main.hour_of_day()) * 2.0
	wind_amount = wind_meter
	rain_amount = rain_meter

func set_positive_negative():
	var possible_positive = ['sun', 'wind', 'rain']
	var possible_negative = ['sun', 'wind', 'rain']

	possible_positive.shuffle()
	possible_negative.shuffle()

	possible_positive.erase(positive)
	possible_negative.erase(negative)

	positive = possible_positive.pop_front()
	possible_negative.erase(positive)
	negative = possible_negative.pop_front()

	time_since_last_reroll = 0.0
