@tool
extends Node3D

@export var main: Node3D

@export_tool_button("Recreate", "Callable") var recreate_callable = recreate

@export var stump_prefabs: Array[PackedScene]
@export var branch_prefabs: Array[PackedScene]


var matter_budget = 0.0

func _ready():
	add_to_group('tree', true)

func recreate():
	for child in get_children():
		child.queue_free()

	matter_budget = 3.0
	
	var new_stump = stump_prefabs[0].instantiate()
	add_child(new_stump)
	new_stump.owner = get_tree().edited_scene_root
	new_stump.activate()

	while(matter_budget > 0.0):
		var new_tree_part = stump_prefabs[0].instantiate()
		var connector = _get_free_connectors().pick_random()
		connector.add_child(new_tree_part)
		new_tree_part.owner = get_tree().edited_scene_root
		new_tree_part.position = Vector3.ZERO
		new_tree_part.activate()

func _get_free_connectors():
	var connectors = main.get_children_in_group(self, 'connector')
	for i in range(len(connectors) -1, -1, -1):
		if connectors[i].get_children() != []:
			connectors.erase(connectors[i])
	return connectors

func _process(_delta):
	if Engine.is_editor_hint():
		pass

	if not Engine.is_editor_hint():
		pass
