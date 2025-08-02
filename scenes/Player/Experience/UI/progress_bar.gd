extends ProgressBar

func _on_archer_player_gained_experience(new_value: float, new_max_value) -> void:
	value += new_value
	
	print("bar increased by: ", new_value, " and now is: ", value)
	
	if value >= max_value:
		var left_over = value - max_value
		value = left_over
		
	print("new max exp: ", new_max_value)
	max_value = new_max_value
		
