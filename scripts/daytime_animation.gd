extends AnimationPlayer



@onready var main = get_node('/root/main')


func _process(_delta: float) -> void:
	if current_animation != 'normal':
		play('normal')

	seek(main.hour_of_day(), true)





