@tool
extends Node3D


var depth = 0.0
var tree = self
var main = self


func _ready() -> void:
	add_to_group('leaf_cluster', true)
	top_level = true
	_get_tree()

func _get_tree():
	if tree == self:
		depth = 0.0
		while not tree.is_in_group('tree'):
			if tree.is_in_group('tree_part'):
				depth += 1.0
			tree = tree.get_parent()
	
	return tree

func _get_main():
	if main == self:
		while not main.is_in_group('main'):
			main = main.get_parent()
	
	return main

func set_growth(growth):
	if self.is_queued_for_deletion():
		return

	var calc_growth = pow(growth * 2.2, 1.8) + 2.5
	calc_growth -= depth*1.0

	for leaf in _get_main().get_children_in_group(self, 'leaf'):		
		leaf.scale = leaf.get_base_scale() * clampf(calc_growth, 0.0, 1.0)
		calc_growth -= 0.5
