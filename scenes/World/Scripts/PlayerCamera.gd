extends Camera2D

@export var body_to_follow: CharacterBody2D

func _physics_process(delta: float) -> void:
	if not body_to_follow: return
	
	global_position = body_to_follow.global_position
