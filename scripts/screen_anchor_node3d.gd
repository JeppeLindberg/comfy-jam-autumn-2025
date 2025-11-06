extends Node2D


var anchor_node_3d = null



func _process(_delta: float) -> void:
	global_position = get_viewport().get_camera_3d().unproject_position(anchor_node_3d.global_position)



