@tool
extends VBoxContainer



@export var filler: Panel
@export var title: RichTextLabel

@export_range(-1.0, 1.0) var meter = 0.0
var prev_meter
@export var title_tex = 'Sun'



func _update_meter():
	filler.custom_minimum_size.x = filler.get_parent().size.x * inverse_lerp(-1.0, 1.0, meter)

func _process(_delta):
	if prev_meter != meter:
		_update_meter()

	prev_meter = meter

	title.text = title_tex

