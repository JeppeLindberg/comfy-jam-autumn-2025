@tool
extends Node3D

var cards
var stats
var seed_anchor

@export var main: Node3D

@export_tool_button("Recreate", "Callable") var recreate_callable = recreate

@export var growth_scale: Curve
@export var stump_prefabs: Array[PackedScene]
@export var branch_prefabs: Array[PackedScene]
@export var leaf_cluster_prefabs: Array[PackedScene]

@export var base_matter_budget = 25.0

@export_range(0.0, 1.0) var growth = 1.0
var prev_growth = 0.0
var enable_grow = false

@export var secs_to_full_grown = 13.0
@export var stop_growing_at_hour = 20.0


func _ready():
	add_to_group('tree', true)

	if not Engine.is_editor_hint():
		cards = get_node('/root/main/cards')
		stats = get_node('/root/main/stats')
		seed_anchor = get_node('/root/main/seed_anchor')

		restart()

func restart():
	enable_grow = false
	if Engine.is_editor_hint():
		recreate()
	else:
		if main.hour_of_day() > 1.0:
			seed_anchor.begin()
		main.fast_forward_to_next_day()

func recreate():
	if not Engine.is_editor_hint():
		growth = 0.0

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
			break

		var possible_new_parts = []
		possible_new_parts.append_array(branch_prefabs)
		possible_new_parts.append_array(stump_prefabs)
		var new_tree_part = possible_new_parts.pick_random().instantiate()

		var connector = null
		var j = 0
		while (connector == null) or (connector.max_sub_part_matter < new_tree_part.matter):
			connector = _get_free_connectors().pick_random()
			j += 1
			if j > 10:
				# print('recursion blocker j')
				connector = null
				break

		if connector == null:
			new_tree_part.queue_free()
			continue

		connector.name = 'connector_'+str(connector_index)
		connector_index += 1
		connector.owner = get_tree().edited_scene_root
		
		connector.add_child(new_tree_part)
		new_tree_part.owner = get_tree().edited_scene_root
		new_tree_part.position = Vector3.ZERO
		new_tree_part.activate()

		var no_of_leaf_clusters = randi_range(1,3)
		while no_of_leaf_clusters > 0:
			var leaf_connector = _get_free_leaf_connector(new_tree_part)
			if leaf_connector == null:
				break
			
			var new_leaf_cluster = leaf_cluster_prefabs.pick_random().instantiate()
			leaf_connector.name = 'leaf_connector_'+str(connector_index)
			connector_index+= 1
			leaf_connector.add_child(new_leaf_cluster)
			leaf_connector.owner = get_tree().edited_scene_root

			no_of_leaf_clusters -= 1

		matter_budget -= new_tree_part.matter
		# print(matter_budget)
	
	prev_growth = -1.0
	enable_grow = true

func _get_free_connectors():
	var connectors = main.get_children_in_group(self, 'connector')
	for i in range(len(connectors) -1, -1, -1):
		if connectors[i].get_children() != []:
			connectors.erase(connectors[i])
	return connectors

func _get_free_leaf_connector(tree_part):
	var leaf_connectors = []
	for child in tree_part.get_children():
		if child.is_in_group('leaf_cluster_connector') and (child.get_children() == []):
			leaf_connectors.append(child)
	if leaf_connectors == []:
		return null
	return leaf_connectors.pick_random()		

func _update_growth():
	var tree_parts = main.get_children_in_group(self, 'tree_part')
	for part in tree_parts:
		part.set_growth(growth)
	var leaf_clusters = main.get_children_in_group(self, 'leaf_cluster')
	for part in leaf_clusters:
		part.set_growth(growth)

func _done_growing():
	if Engine.is_editor_hint():
		return;
	
	if not cards.cards_available():
		cards.generate_cards()

func _process(delta):
	visible = enable_grow

	if enable_grow:
		if not Engine.is_editor_hint():
			growth += clampf(stats.get_growth_factor() *( 1.0/secs_to_full_grown )* delta, 0.0, 1.0)
			if growth > 1.0:
				growth = 1.0

		if (not Engine.is_editor_hint()) and (main.hour_of_day() >= stop_growing_at_hour):
			_done_growing()
		elif prev_growth != growth:
			_update_growth()
		elif growth > 0.01:
			_done_growing()

		if Engine.is_editor_hint():
			pass
		
		prev_growth = growth


func _on_main_new_day_signal() -> void:
	recreate()
