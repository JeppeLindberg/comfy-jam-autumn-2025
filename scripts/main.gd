@tool
extends Node3D

@export var seconds_per_day = 30.0

var time_dialation = 1.0

@export var hours = 0.0


signal new_day_signal()

func _process(delta: float) -> void:
	if not Engine.is_editor_hint():
		hours += delta * 24.0 * time_dialation * (1.0/seconds_per_day)
		if hours > 24.0:
			hours -= 24.0
			time_dialation = 1.0
			emit_signal('new_day_signal')

var _result

func get_children_in_group(node, group):
	_result = []

	_get_children_in_group_recursive(node, group)

	return _result

func _get_children_in_group_recursive(node, group):
	for child in node.get_children():
		if child.is_queued_for_deletion():
			continue

		if group == '' or child.is_in_group(group):
			_result.append(child)

		_get_children_in_group_recursive(child, group)

func hour_of_day():
	var result = hours
	while (result > 24.0):
		result -= 24.0
	return result

func fast_forward_to_next_day():
	if hours > 1.0:
		time_dialation = 5.0
	else:
		time_dialation = 1.0
		emit_signal('new_day_signal')
