extends ProgressBar

func _on_archer_player_gained_experience(new_value: float, new_max_value) -> void:
	value = new_value
	max_value = new_max_value
