extends Button


@onready var stats = get_node('/root/main/stats')
@onready var cards = get_node('/root/main/cards')
@onready var tree = get_node('/root/main/tree')

@export_multiline var card_text = 'text'

@export var sun_absorption_delta: int = 0
@export var wind_resistance_delta: int = 0
@export var rain_absorption_delta: int = 0

@export var text_label: RichTextLabel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	text_label.text = card_text.replace('\\n', '\n')


func _on_pressed() -> void:
	stats.sun_absorption += sun_absorption_delta
	stats.wind_resistance += wind_resistance_delta
	stats.rain_absorption += rain_absorption_delta

	cards.clear_cards()

	tree.restart()


func _on_button_down() -> void:
	print('_on_button_down')

func _on_button_up() -> void:
	print('_on_button_up')

func _on_mouse_exited() -> void:
	print('_on_mouse_exited')	

func _on_mouse_entered() -> void:
	print('_on_mouse_entered')	
