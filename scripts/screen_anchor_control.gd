@tool
extends Node2D


var anchor_control = null



func _process(_delta: float) -> void:
	if anchor_control != null:
		global_position = round(anchor_control.global_position)	
	if (anchor_control == null) or (anchor_control.is_queued_for_deletion()):
		queue_free()


func _exit_tree() -> void:
	if anchor_control == null:
		return
	if anchor_control.sprite_anchor == self:
		anchor_control.sprite_anchor = null
	if not is_queued_for_deletion():
		queue_free()
