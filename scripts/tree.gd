@tool
extends Node3D

@onready var cards = get_node('/root/main/cards')
@onready var stats = get_node('/root/main/stats')

@export var main: Node3D

@export_tool_button("Recreate", "Callable") var recreate_callable = recreate

@export var growth_scale: Curve
@export var stump_prefabs: Array[PackedScene]
@export var branch_prefabs: Array[PackedScene]
@export var base_matter_budget = 25.0

@export_range(0.0, 1.0) var growth = 1.0
var prev_growth = 0.0

@export var secs_to_full_grown = 13.0


func _ready():
	add_to_group('tree', true)

	if not Engine.is_editor_hint():
		restart()

func restart():
	growth = 0.0

	recreate()

func recreate():
	for child in get_children():
		child.queue_free()

	var matter_budget = base_matter_budget
	
	var new_stump = stump_prefabs.pick_random().instantiate()
	add_child(new_stump)
	new_stump.owner = get_tree().edited_scene_root
	new_stump.activate()

	var connector_index = 0
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

		connector.name = 'branch_'+str(connector_index)
		connector_index += 1
		connector.owner = get_tree().edited_scene_root
		
		connector.add_child(new_tree_part)
		new_tree_part.owner = get_tree().edited_scene_root
		new_tree_part.position = Vector3.ZERO
		new_tree_part.activate()

		matter_budget -= new_tree_part.matter
		print(matter_budget)
	
	prev_growth = -1.0

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

func _done_growing():
	if Engine.is_editor_hint():
		return;
	
	if not cards.cards_available():
		cards.generate_cards()

func _process(delta):
	if not Engine.is_editor_hint():
		growth += clampf(stats.get_growth_factor() *( 1.0/secs_to_full_grown )* delta, 0.0, 1.0)
		if growth > 1.0:
			growth = 1.0

	if prev_growth != growth:
		_update_growth()
	elif growth > 0.01:
		_done_growing()

	if Engine.is_editor_hint():
		pass
	
	prev_growth = growth
