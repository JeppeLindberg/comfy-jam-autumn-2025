extends Node3D

@export var cards_container: Control



func clear_cards():
	for card in cards_container.get_children():
		card.queue_free()
