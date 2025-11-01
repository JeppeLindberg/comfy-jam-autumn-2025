@tool
extends Node3D

@export var stump = false
@export var matter = 1.0

var depth = 0.0
var tree = self


func activate():
	add_to_group('tree_part', true)

	for child in get_children():
		if child.has_method('activate'):
			child.activate()
	
	top_level = true
	_get_tree()

func _get_tree():
	if tree == self:
		depth = 0.0
		while not tree.is_in_group('tree'):
			depth += 1.0
			tree = tree.get_parent()
	
	return tree

func set_growth(growth):
	if self.is_queued_for_deletion():
		return

	var calc_growth = growth * 2.0
	calc_growth -= depth*0.1
	if stump:
		calc_growth *= 0.5
	var growth_y = _get_tree().growth_scale.sample(clamp(calc_growth, 0.0, 1.0))
	var growth_x = _get_tree().growth_scale.sample(clamp(calc_growth * 0.7, 0.0, 1.0))
	scale = Vector3(growth_x, growth_y, growth_x)

	for connector in _get_tree().main.get_children_in_group(self, 'connector'):
		for child in connector.get_children():
			if child.top_level:
				child.global_position = connector.global_position
				child.global_rotation = connector.global_rotation

