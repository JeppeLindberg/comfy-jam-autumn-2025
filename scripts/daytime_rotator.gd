extends Node3D



@onready var main = get_node('/root/main')

var base_rot_z = 0.0


func _ready():
	base_rot_z = rotation_degrees.z

func _process(_delta: float) -> void:
	rotation_degrees.z = base_rot_z + (main.hour_of_day() / 24.0 * 360)



