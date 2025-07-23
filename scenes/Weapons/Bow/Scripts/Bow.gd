extends Node2D

var arrow_scene = preload("res://scenes/Weapons/Bow/Arrow.tscn")
@export var player: Player
@export var stats: StatsComponent

var radius = 15

func _physics_process(delta: float) -> void:
	var mouse_pos = get_global_mouse_position()
	
	var direction = (mouse_pos - player.global_position).normalized()
	
	position = position.lerp(direction * radius, 10 * delta)
	
	if position.x > 0: %FWSprite.flip_h = false
	else: %FWSprite.flip_h = true
	
func get_closest_enemy() -> Enemy:
	var alive_enemies = get_tree().get_nodes_in_group("Enemies")
	
	var closest_enemy: Enemy
	
	if not alive_enemies.size():
		closest_enemy = null
		return
		
	for enemy: Enemy in alive_enemies:
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
	var total_attack = stats.attack
	
	var random_number = randf()
	
	var normalized_chance_to_crit: float = stats.critical_chance / 100
	
	var should_crit = random_number < normalized_chance_to_crit
	
	if should_crit:
		total_attack += (stats.attack * stats.critical_damage) / 100
		
	return total_attack
	
