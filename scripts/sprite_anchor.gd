@tool
extends Control


@export var texture: Texture

var main = self
var sprites = self


var sprite_anchor = null


func _process(_delta: float) -> void:
	if (sprite_anchor == null) or (sprite_anchor.is_queued_for_deletion()):
		if _get_sprites() == null:
			return
			
		sprite_anchor = _get_main().generic_sprite_anchor.instantiate()
		_get_sprites().add_child(sprite_anchor)
		sprite_anchor.owner = get_tree().edited_scene_root
		sprite_anchor.anchor_control = self
		sprite_anchor.get_node('sprite').texture = texture;

func _get_main():
	if main == self:
		while not main.is_in_group('main'):
			main = main.get_parent()
	
	if main == self:
		return null
	return main

func _get_sprites():
	if _get_main() == null:
		return null
	return _get_main().get_node_or_null('sprites')

