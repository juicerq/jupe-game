extends Node2D
class_name World

var enemy_scene = preload("res://scenes/Enemy/Enemy.tscn")

func _on_timer_timeout() -> void:
	var enemy = enemy_scene.instantiate()
	
	get_tree().current_scene.add_child(enemy)
	
	if enemy is Enemy:
		enemy.global_position = Vector2.ZERO
	
