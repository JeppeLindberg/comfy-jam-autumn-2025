@tool
extends Node3D

var _result

func get_children_in_group(node, group):
	_result = []

	_get_children_in_group_recursive(node, group)

	return _result

func _get_children_in_group_recursive(node, group):
	for child in node.get_children():
		if child.is_queued_for_deletion():
			continue

		if child.is_in_group(group):
			_result.append(child)

		_get_children_in_group_recursive(child, group)
	