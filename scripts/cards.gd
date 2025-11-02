extends Node3D

@export var cards_container: Control

@export var cards: Array[PackedScene]

@onready var main = get_node('/root/main')



func clear_cards():
	for card in cards_container.get_children():
		card.queue_free()

	main.time_dialation = 1.0

func cards_available():
	if len(cards_container.get_children()) > 0:
		return true
	else:
		return false

func generate_cards():
	var possible_new_cards = []
	possible_new_cards.append_array(cards)
	possible_new_cards.shuffle()
	var new_card_1 = possible_new_cards.pop_front().instantiate()
	cards_container.add_child(new_card_1)
	var new_card_2 = possible_new_cards.pop_front().instantiate()
	cards_container.add_child(new_card_2)

	main.time_dialation = 0.0
