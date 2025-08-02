extends Node2D

var arrow_scene = preload("res://scenes/Weapons/Bow/Arrow.tscn")
@export var player: Player
@export var stats: StatsComponent
@export var Sprite: AnimatedSprite2D

var radius = 15

func _physics_process(delta: float) -> void:
	var mouse_pos = get_global_mouse_position()
	
	var direction = (mouse_pos - player.global_position).normalized()
	
	position = position.lerp(direction * radius, 10 * delta)
	
	if position.x > 0: Sprite.flip_h = false
	else: Sprite.flip_h = true

func _on_fw_timer_timeout() -> void:
	Sprite.play("attack")
	
	await Sprite.animation_finished
	
	var arrow: Arrow = arrow_scene.instantiate()
	
	get_tree().current_scene.add_child(arrow)
	
	arrow.global_position = %FWArrowSpawnPosition.global_position
	
	var mouse_pos = get_global_mouse_position()
	
	var arrow_direction = (mouse_pos - arrow.global_position).normalized()
	
	arrow.damage = get_damage()
	
	arrow.direction = arrow_direction
	%FWTimer.start()
	
	#print("finished attack")
	

func get_damage():
	var total_attack = stats.attack
	
	var random_number = randf()
	
	var normalized_chance_to_crit: float = stats.critical_chance / 100
	
	var should_crit = random_number < normalized_chance_to_crit
	
	if should_crit:
		total_attack += (stats.attack * stats.critical_damage) / 100
		
	return total_attack
	
