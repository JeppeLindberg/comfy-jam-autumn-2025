@tool
extends Control




@export var filler: Panel
@export var title: RichTextLabel

@export var image_anchor: Control

@export_range(-1.0, 1.0) var meter = 0.0
var prev_meter
@export var title_tex = 'Sun'


@export var full_sun_texture: Texture
@export var wind_texture: Texture
@export var rain_texture: Texture

@export var associated_parameter = 'sun'

@export var arrow_left: Control
@export var arrow_right: Control

var parameters = null


func _update_meter():
	filler.custom_minimum_size.x = filler.get_parent().size.x * inverse_lerp(-1.0, 1.0, meter)

func _process(_delta):
	if prev_meter != meter:
		_update_meter()

	prev_meter = meter

	title.text = title_tex

	if full_sun_texture != null:
		image_anchor.texture = full_sun_texture
	if wind_texture != null:
		image_anchor.texture = wind_texture
	if rain_texture != null:
		image_anchor.texture = rain_texture

	
	if not Engine.is_editor_hint():
		if parameters == null:
			parameters = get_node('/root/main/parameters')
		arrow_right.sprite_visible = parameters.positive == associated_parameter
		arrow_left.sprite_visible = parameters.negative == associated_parameter

