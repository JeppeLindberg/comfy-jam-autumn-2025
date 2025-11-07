@tool
extends Node2D


var anchor_control = null
var main = self


func _process(_delta: float) -> void:
	update()

func update():
	if not _is_child_of_main():
		return

	if anchor_control != null:
		global_position = floor(anchor_control.global_position)	
	if (anchor_control == null) or (anchor_control.is_queued_for_deletion()):
		queue_free()

func _exit_tree() -> void:
	if anchor_control == null:
		return
	if anchor_control.sprite_anchor == self:
		anchor_control.sprite_anchor = null
	if not is_queued_for_deletion():
		queue_free()

func _is_child_of_main():
	var _main = _get_main()
	if (_main == null) or (_main == self):
		return false
	return true

func _get_main():
	if main == self:
		while not main.is_in_group('main'):
			main = main.get_parent()
			if main == null:
				return null
	
	if main == self:
		return null
	return main
