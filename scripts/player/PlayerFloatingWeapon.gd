extends Node2D

var arrow_scene = preload("res://scenes/Arrow.tscn")
@export var player: CharacterBody2D
var closest_enemy: CharacterBody2D

var radius = 15

func _physics_process(delta: float) -> void:
	var mouse_pos = get_global_mouse_position()
	
	var direction = (mouse_pos - player.global_position).normalized()
	
	position = position.lerp(direction * radius, 10 * delta)
	
	if position.x > 0: %FWSprite.flip_h = false
	else: %FWSprite.flip_h = true


func _on_fw_timer_timeout() -> void:
	var enemies = get_tree().get_nodes_in_group("Enemies")
	
	if not enemies.size():
		closest_enemy = null
		return
	
	for enemy: CharacterBody2D in enemies:
		var distance = enemy.global_position.distance_to(%FWArrowSpawnPosition.global_position)
		
		if not closest_enemy:
			closest_enemy = enemy
		
		if distance < (closest_enemy.global_position.distance_to(%FWArrowSpawnPosition.global_position)) :
			closest_enemy = enemy
	
	var arrow = arrow_scene.instantiate()
	
	get_tree().current_scene.add_child(arrow)
	
	arrow.global_position = %FWArrowSpawnPosition.global_position
	
	var enemy_direction = (closest_enemy.global_position - arrow.global_position).normalized()
	
	arrow.set_direction(enemy_direction)
	arrow.damage = %StatsComponent.attack
