extends Node3D

@onready var parameters = get_node('/root/main/parameters')
@onready var main = get_node('/root/main')

@export var sun_absorption: int = 0
@export var wind_resistance: int = 0
@export var rain_absorption: int = 0

@export var stats_text: RichTextLabel

var prev_stats = {}

func _process(_delta: float) -> void:

	var stats_dir = {
		'sun_absorption':sun_absorption,
		'wind_resistance':wind_resistance,
		'rain_absorption':rain_absorption
	}

	if stats_dir != prev_stats:
		_update_stats()

	prev_stats = stats_dir


func _update_stats():
	print('sun_absorption: '+str(sun_absorption)+' wind_resistance: '+str(wind_resistance)+' rain_absorption: '+str(rain_absorption))
	stats_text.update()


func get_growth_factor():
	var sun_factor_calc = (sun_absorption + 3.0) * inverse_lerp(-1.0, 1.0, parameters.sun_amount)
	sun_factor_calc = clampf(sun_factor_calc, 0.0, 10.0)

	var wind_factor_calc = (wind_resistance + 3.0) * inverse_lerp(-1.0, 1.0, parameters.wind_amount)
	wind_factor_calc = clampf(wind_factor_calc, 0.0, 10.0)
	
	var rain_factor_calc = (rain_absorption + 3.0) * inverse_lerp(-1.0, 1.0, parameters.rain_amount)
	rain_factor_calc = clampf(rain_factor_calc, 0.0, 10.0)
	
	return main.time_dialation * clampf((sun_factor_calc + wind_factor_calc + rain_factor_calc) / 9.0, 0.0, 10.0)


