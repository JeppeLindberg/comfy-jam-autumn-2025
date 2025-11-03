@tool
extends Node3D


var base_scale = Vector3.ZERO


func get_base_scale():
	if base_scale == Vector3.ZERO:
		base_scale = scale
	return base_scale

func _ready():
	add_to_group('leaf', true)

