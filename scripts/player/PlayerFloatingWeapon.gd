extends Node2D

@export var player: CharacterBody2D

var radius = 15

func _process(delta):
	var mouse_pos = get_global_mouse_position()
	
	var direction = (mouse_pos - player.global_position).normalized()
	
	position = position.lerp(direction * radius, 10 * delta)
	
	if position.x > 0: %FWSprite.flip_h = false
	else: %FWSprite.flip_h = true
		
