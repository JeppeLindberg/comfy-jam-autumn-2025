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

	var calc_growth = growth * 5.0 + 0.5
	calc_growth -= depth*0.1

	for leaf in _get_main().get_children_in_group(self, 'leaf'):
		leaf.scale = leaf.get_base_scale() * clampf(calc_growth, 0.0, 1.0)
		calc_growth -= 1.0

func _process(_delta: float) -> void:
	var parent = get_parent()
	if not parent is Node3D:
		return
	global_position = get_parent().global_position
	global_rotation = get_parent().global_rotation
