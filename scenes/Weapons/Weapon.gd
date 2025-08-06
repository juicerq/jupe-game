extends Node2D
class_name Weapon

@export var Player: Player 
@onready var Sprite: Sprite2D = $Sprite

# TODO: adicionar buff pra radius em melees
var radius = 15

func _physics_process(delta: float) -> void:
	var mouse_pos = get_global_mouse_position()
	
	var direction = (mouse_pos - Player.global_position).normalized()
	
	position = position.lerp(direction * radius, 10 * delta)
	
	if position.x > 0: Sprite.flip_h = false
	else: Sprite.flip_h = true

func get_damage():
	var total_attack = Player.stats_component.attack
	
	var random_number = randf()
	
	var normalized_chance_to_crit: float = Player.stats_component.critical_chance / 100
	
	var should_crit = random_number < normalized_chance_to_crit
	
	if should_crit:
		total_attack += (Player.stats_component.attack * Player.stats_component.critical_damage) / 100
	
	return total_attack

func attack():
	pass

func _on_attack_timer_timeout() -> void:
	attack()
