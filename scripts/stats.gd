extends Node3D

@export var sun_absorption: int = 0
@export var wind_resistance: int = 0
@export var water_absorption: int = 0

var prev_stats = {}

func _process(_delta: float) -> void:
	var stats_dir = {
		'sun_absorption':sun_absorption,
		'wind_resistance':wind_resistance,
		'water_absorption':water_absorption
	}

	if stats_dir != prev_stats:
		_update_stats()

	prev_stats = stats_dir


func _update_stats():
	print('sun_absorption: '+str(sun_absorption)+' wind_resistance: '+str(wind_resistance)+' water_absorption: '+str(water_absorption))



