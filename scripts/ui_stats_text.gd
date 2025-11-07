extends RichTextLabel


@onready var stats = get_node('/root/main/stats')

@export var green_hex = 'FFDD3D'
@export var red_hex = 'EF6544'


func update():
	var replace_txt = ''
	self.text = ''
	
	if stats.sun_absorption > 0:
		replace_txt = ''
		for i in range(stats.sun_absorption):
			replace_txt += '+'
		if self.text != '':
			self.text += '\n'
		self.text += '[color=#' + green_hex+ ']'+replace_txt+' sun absorption[/color]'
	if stats.wind_resistance > 0:
		replace_txt = ''
		for i in range(stats.wind_resistance):
			replace_txt += '+'
		if self.text != '':
			self.text += '\n'
		self.text += '[color=#' + green_hex+ ']'+replace_txt+' wind resistance[/color]'
	if stats.rain_absorption > 0:
		replace_txt = ''
		for i in range(stats.rain_absorption):
			replace_txt += '+'
		if self.text != '':
			self.text += '\n'
		self.text += '[color=#' + green_hex+ ']'+replace_txt+' rain absorption[/color]'

	if stats.sun_absorption < 0:
		replace_txt = ''
		for i in range(-stats.sun_absorption):
			replace_txt += '-'
		if self.text != '':
			self.text += '\n'
		self.text += '[color='+red_hex+']'+replace_txt+' sun absorption[/color]'
	if stats.wind_resistance < 0:
		replace_txt = ''
		for i in range(-stats.wind_resistance):
			replace_txt += '-'
		if self.text != '':
			self.text += '\n'
		self.text += '[color='+red_hex+']'+replace_txt+' wind resistance[/color]'
	if stats.rain_absorption < 0:
		replace_txt = ''
		for i in range(-stats.rain_absorption):
			replace_txt += '-'
		if self.text != '':
			self.text += '\n'
		self.text += '[color='+red_hex+']'+replace_txt+' rain absorption[/color]'
		 