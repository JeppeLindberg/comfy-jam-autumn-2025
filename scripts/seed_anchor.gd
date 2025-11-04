extends Node3D


@onready var sprites = get_node('/root/main/sprites')
@onready var tree = get_node('/root/main/tree')
@onready var main = get_node('/root/main')

@export var anchor: Node3D
@export var sprite_seed_prefab :PackedScene

@export var vert_curve: Curve

var sprite = null
var from_pos
var to_pos
var from_time
var to_time


func begin():
	var new_sprite = sprite_seed_prefab.instantiate()
	new_sprite.anchor_node_3d = anchor
	sprites.add_child(new_sprite)
	sprite = new_sprite

	var tree_children = main.get_children_in_group(tree, '')
	var avg_pos = Vector3.ZERO
	for child in tree_children:
		avg_pos += child.global_position
	if len(tree_children) > 0:
		avg_pos /= len(tree_children)
	from_pos = avg_pos
	to_pos = tree.global_position
	from_time = main.hour_of_day()
	to_time = 24.0

func _process(_delta: float) -> void:
	if sprite == null:
		return
	elif sprite.is_queued_for_deletion():
		return
	elif (main.hour_of_day() < from_time) or (to_time < main.hour_of_day()):
		sprite.queue_free()
		return
	
	var weight = inverse_lerp(from_time, to_time, main.hour_of_day())
	anchor.global_position = lerp(from_pos, to_pos, weight) + (Vector3.UP * vert_curve.sample(weight) * 5.0)
