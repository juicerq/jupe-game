extends Node
class_name EnemyWave

@export var Player: Player
@export var Camera: Camera2D
var enemy_scene = preload("res://scenes/Enemy/Enemy.tscn")

func _on_timer_timeout() -> void:
	var random_number: int = randf_range(1, 5)
	
	var enemy = enemy_scene.instantiate()
	
	var view_size: Vector2 = Camera.get_viewport().get_visible_rect().size / Camera.zoom
	var half_w := view_size.x * 0.5
	var half_h := view_size.y * 0.5
	var center: Vector2 = Camera.global_position
	
	var left_edge := center.x - half_w
	var right_edge := center.x + half_w
	var top_edge := center.y - half_h
	var bottom_edge := center.y + half_h
	
	# Margem para spawn fora da tela
	var margin := 64.0
	
	match random_number:
		1:
			var x = left_edge - margin
			var y = randf_range(top_edge, bottom_edge)
			enemy.global_position = Vector2(x, y)
			get_tree().current_scene.add_child(enemy)
		2:
			var x = right_edge + margin
			var y = randf_range(top_edge, bottom_edge)
			enemy.global_position = Vector2(x, y)
			get_tree().current_scene.add_child(enemy)
		3:
			var y = top_edge - margin
			var x = randf_range(left_edge, right_edge)
			enemy.global_position = Vector2(x, y)
			get_tree().current_scene.add_child(enemy)
		4:
			var y = bottom_edge + margin
			var x = randf_range(left_edge, right_edge)
			enemy.global_position = Vector2(x, y)
			get_tree().current_scene.add_child(enemy)
