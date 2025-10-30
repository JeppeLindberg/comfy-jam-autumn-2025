@tool
extends Node3D



var _tree_part
var max_sub_part_matter

func activate():
	add_to_group('connector', true)

	_tree_part = self
	while not _tree_part.is_in_group('tree_part'):
		_tree_part = _tree_part.get_parent()
	
	max_sub_part_matter = _tree_part.matter * 0.99


