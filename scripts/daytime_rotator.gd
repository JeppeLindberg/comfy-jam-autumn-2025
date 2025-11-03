extends Node3D



@onready var main = get_node('/root/main')

var base_rot_y = 0.0


func _ready():
	base_rot_y = rotation_degrees.y

func _process(_delta: float) -> void:
	rotation_degrees.y = base_rot_y + (main.hour_of_day() / 24.0 * 360)



