extends Node2D

var arrow_scene = preload("res://scenes/Arrow.tscn")
@export var player: CharacterBody2D

var radius = 15

func _physics_process(delta: float) -> void:
	var mouse_pos = get_global_mouse_position()
	
	var direction = (mouse_pos - player.global_position).normalized()
	
	position = position.lerp(direction * radius, 10 * delta)
	
	if position.x > 0: %FWSprite.flip_h = false
	else: %FWSprite.flip_h = true

func check_enemy_alive(enemy: CharacterBody2D):
	if not enemy: return false
	
	var enemy_health = enemy.get_node("HealthComponent")
	
	print(enemy_health.is_dead)
	
	return not enemy_health.is_dead
	
func get_closest_enemy() -> CharacterBody2D:
	var enemies = get_tree().get_nodes_in_group("Enemies")
	
	var alive_enemies = enemies.filter(check_enemy_alive)
	
	var closest_enemy: CharacterBody2D
	
	if not alive_enemies.size():
		closest_enemy = null
		return
		
	for enemy: CharacterBody2D in alive_enemies:
		if not closest_enemy:
			closest_enemy = enemy
			
		var distance = enemy.global_position.distance_to(%FWArrowSpawnPosition.global_position)
		
		if distance < (closest_enemy.global_position.distance_to(%FWArrowSpawnPosition.global_position)) :
			closest_enemy = enemy
	
	return closest_enemy

func _on_fw_timer_timeout() -> void:
	var closest_enemy = get_closest_enemy()
	
	if not closest_enemy: return
	
	var arrow = arrow_scene.instantiate()
	
	get_tree().current_scene.add_child(arrow)
	
	arrow.global_position = %FWArrowSpawnPosition.global_position
	
	var feet_enemy_pos = (closest_enemy.global_position + Vector2(0, 8))
	
	var enemy_direction = (feet_enemy_pos - arrow.global_position).normalized()
	
	arrow.set_direction(enemy_direction)
	
	arrow.damage = get_damage()
	
func get_damage():
	var total_attack = %StatsComponent.attack
	
	var random_number = randf()
	
	var normalized_chance_to_crit: float = %StatsComponent.critical_chance / 100
	
	var should_crit = random_number < normalized_chance_to_crit
	
	if should_crit:
		total_attack = (%StatsComponent.attack * (%StatsComponent.critical_damage_multiplier * 100) / 100)
		
	return total_attack
	
