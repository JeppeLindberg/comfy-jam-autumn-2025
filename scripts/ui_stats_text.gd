extends RichTextLabel


@onready var stats = get_node('/root/main/stats')


func update():
	var replace_txt = ''
	self.text = ''
	
	if stats.sun_absorption > 0:
		replace_txt = ''
		for i in range(stats.sun_absorption):
			replace_txt += '+'
		if self.text != '':
			self.text += '\n'
		self.text += '[color=green]'+replace_txt+' sun absorption[/color]'
	if stats.wind_resistance > 0:
		replace_txt = ''
		for i in range(stats.wind_resistance):
			replace_txt += '+'
		if self.text != '':
			self.text += '\n'
		self.text += '[color=green]'+replace_txt+' wind resistance[/color]'
	if stats.water_absorption > 0:
		replace_txt = ''
		for i in range(stats.water_absorption):
			replace_txt += '+'
		if self.text != '':
			self.text += '\n'
		self.text += '[color=green]'+replace_txt+' water absorption[/color]'

	if stats.sun_absorption < 0:
		replace_txt = ''
		for i in range(-stats.sun_absorption):
			replace_txt += '-'
		if self.text != '':
			self.text += '\n'
		self.text += '[color=red]'+replace_txt+' sun absorption[/color]'
	if stats.wind_resistance < 0:
		replace_txt = ''
		for i in range(-stats.wind_resistance):
			replace_txt += '-'
		if self.text != '':
			self.text += '\n'
		self.text += '[color=red]'+replace_txt+' wind resistance[/color]'
	if stats.water_absorption < 0:
		replace_txt = ''
		for i in range(-stats.water_absorption):
			replace_txt += '-'
		if self.text != '':
			self.text += '\n'
		self.text += '[color=red]'+replace_txt+' water absorption[/color]'
		 