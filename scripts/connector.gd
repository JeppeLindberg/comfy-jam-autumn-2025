@tool
extends Node3D



func activate():
	add_to_group('connector', true)


func _ready() -> void:
	activate()
