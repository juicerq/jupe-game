extends Node
class_name EnemyWave

@export var Player: Player
@export var Camera: Camera2D
var enemy_scene = preload("res://scenes/Enemy/Enemy.tscn")

func _on_timer_timeout() -> void:
	var random_number: int = randf_range(1, 5)
	
	var enemy = enemy_scene.instantiate()
	
	var visible_width = Camera.get_viewport().get_visible_rect().size.x / Camera.zoom.x
	var visible_height = Camera.get_viewport().get_visible_rect().size.y / Camera.zoom.y
	
	var left_outside = Camera.get_screen_center_position().x - visible_width
	var right_outside = Camera.get_screen_center_position().x + visible_width
	
	var top_outside = Camera.get_screen_center_position().y - visible_height
	var bottom_outside = Camera.get_screen_center_position().y + visible_height
	
	match random_number:
		1:
			var x = left_outside + 250;
			var y = randf_range(top_outside, bottom_outside)
			get_tree().current_scene.add_child(enemy)
			enemy.global_position = Vector2(x, y)
		2:
			var x = right_outside - 250;
			var y = randf_range(top_outside, bottom_outside)
			get_tree().current_scene.add_child(enemy)
			enemy.global_position = Vector2(x, y)
		3:
			var y = top_outside + 100
			var x = randf_range(left_outside, right_outside)
			get_tree().current_scene.add_child(enemy)
			enemy.global_position = Vector2(x, y)
		4:
			var y = bottom_outside - 100
			var x = randf_range(left_outside, right_outside)
			get_tree().current_scene.add_child(enemy)
			enemy.global_position = Vector2(x, y)
