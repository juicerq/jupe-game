extends Camera2D

func _physics_process(delta: float) -> void:
	var player = %Player
	
	if not player:
		return
	
	position = %Player.position
