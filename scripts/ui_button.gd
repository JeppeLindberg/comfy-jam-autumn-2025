extends Button


@export_multiline var card_text = 'text'

@export var sun_absorption_delta: int = 0
@export var wind_resistance_delta: int = 0
@export var water_absorption_delta: int = 0

@export var text_label: RichTextLabel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	text_label.text = card_text.replace('\\n', '\n')


func _on_pressed() -> void:
	print('_on_pressed')


func _on_button_down() -> void:
	print('_on_button_down')

func _on_button_up() -> void:
	print('_on_button_up')

func _on_mouse_exited() -> void:
	print('_on_mouse_exited')	

func _on_mouse_entered() -> void:
	print('_on_mouse_entered')	
