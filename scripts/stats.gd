extends Node3D

@export var sun_absorption: int = 0
@export var wind_resistance: int = 0
@export var water_absorption: int = 0

@export var stats_text: RichTextLabel

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
	var replace_txt = ''
	stats_text.text = ''
	
	if sun_absorption > 0:
		replace_txt = ''
		for i in range(sun_absorption):
			replace_txt += '+'
		if stats_text.text != '':
			stats_text.text += '\n'
		stats_text.text += '[color=green]'+replace_txt+' sun absorption[/color]'
	if wind_resistance > 0:
		replace_txt = ''
		for i in range(wind_resistance):
			replace_txt += '+'
		if stats_text.text != '':
			stats_text.text += '\n'
		stats_text.text += '[color=green]'+replace_txt+' wind resistance[/color]'
	if water_absorption > 0:
		replace_txt = ''
		for i in range(water_absorption):
			replace_txt += '+'
		if stats_text.text != '':
			stats_text.text += '\n'
		stats_text.text += '[color=green]'+replace_txt+' water absorption[/color]'

	if sun_absorption < 0:
		replace_txt = ''
		for i in range(-sun_absorption):
			replace_txt += '-'
		if stats_text.text != '':
			stats_text.text += '\n'
		stats_text.text += '[color=red]'+replace_txt+' sun absorption[/color]'
	if wind_resistance < 0:
		replace_txt = ''
		for i in range(-wind_resistance):
			replace_txt += '-'
		if stats_text.text != '':
			stats_text.text += '\n'
		stats_text.text += '[color=red]'+replace_txt+' wind resistance[/color]'
	if water_absorption < 0:
		replace_txt = ''
		for i in range(-water_absorption):
			replace_txt += '-'
		if stats_text.text != '':
			stats_text.text += '\n'
		stats_text.text += '[color=red]'+replace_txt+' water absorption[/color]'
		 
	print('sun_absorption: '+str(sun_absorption)+' wind_resistance: '+str(wind_resistance)+' water_absorption: '+str(water_absorption))



