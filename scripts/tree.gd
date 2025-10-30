@tool
extends Node3D

@export var main: Node3D

@export_tool_button("Recreate", "Callable") var recreate_callable = recreate

@export var growth_scale: Curve
@export var stump_prefabs: Array[PackedScene]
@export var branch_prefabs: Array[PackedScene]
@export var base_matter_budget = 25.0

@export_range(0.0, 1.0) var growth = 1.0

var growth_history = []


func _ready():
	add_to_group('tree', true)

func recreate():
	for child in get_children():
		child.queue_free()

	var matter_budget = base_matter_budget
	
	var new_stump = stump_prefabs.pick_random().instantiate()
	add_child(new_stump)
	new_stump.owner = get_tree().edited_scene_root
	new_stump.activate()

	var i = 0
	while(matter_budget > 0.0):
		i += 1
		if i > 100:
			print('recursion blocker i')
			return

		var possible_new_parts = []
		possible_new_parts.append_array(branch_prefabs)
		possible_new_parts.append_array(stump_prefabs)
		var new_tree_part = possible_new_parts.pick_random().instantiate()

		var connector = null
		var j = 0
		while (connector == null) or (connector.max_sub_part_matter < new_tree_part.matter):
			connector = _get_free_connectors().pick_random()
			j += 1
			if j > 100:
				# print('recursion blocker j')
				connector = null
				break

		if connector == null:
			new_tree_part.queue_free()
			continue

		connector.add_child(new_tree_part)
		new_tree_part.owner = get_tree().edited_scene_root
		new_tree_part.position = Vector3.ZERO
		new_tree_part.activate()

		matter_budget -= new_tree_part.matter
		print(matter_budget)

func _get_free_connectors():
	var connectors = main.get_children_in_group(self, 'connector')
	for i in range(len(connectors) -1, -1, -1):
		if connectors[i].get_children() != []:
			connectors.erase(connectors[i])
	return connectors

func _update_growth():
	var tree_parts = main.get_children_in_group(self, 'tree_part')
	for part in tree_parts:
		part.set_growth(growth)

func _process(_delta):
	if growth_history == []:
		growth_history = [growth, growth]

	growth_history.append(growth)
	growth_history.pop_front()

	if growth_history[0] != growth_history[1]:
		_update_growth()

	if Engine.is_editor_hint():
		pass

	if not Engine.is_editor_hint():
		pass
	
	growth_history.append(growth)
	growth_history.pop_front()
