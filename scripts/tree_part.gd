@tool
extends Node3D

@export var matter = 1.0



func activate():
	add_to_group('tree_part', true)

	for child in get_children():
		if child.has_method('activate'):
			child.activate()
	
	var tree = self
	while not tree.is_in_group('tree'):
		tree = tree.get_parent()
	# tree.matter_budget -= matter

