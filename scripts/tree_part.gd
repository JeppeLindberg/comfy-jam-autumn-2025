@tool
extends Node3D

@export var matter = 1.0

var depth = 0.0
var tree = self


func activate():
	add_to_group('tree_part', true)

	for child in get_children():
		if child.has_method('activate'):
			child.activate()
	
	tree = self
	depth = 0.0
	while not tree.is_in_group('tree'):
		depth += 1.0
		tree = tree.get_parent()

func set_growth(growth):
	var calc_growth = growth * 2.0
	calc_growth -= depth*0.1
	scale = Vector3.ONE * tree.growth_scale.sample(clamp(calc_growth, 0.0, 1.0))

