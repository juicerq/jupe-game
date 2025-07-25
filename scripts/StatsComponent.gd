extends Node
class_name StatsComponent

@export var max_health: int
@export var attack: int
@export var critical_chance: float
@export var critical_damage: float
@export var defense: int

@export var Level: LevelComponent

func _ready() -> void:
	recalculate_all_stats()

#func calculate_total_attack() -> int:
	#var level = Level.current_level
	#
	#var additional_per_level = (Level.stats_per_level["attack"]) * (level - 1)
	#
	#var total_attack = attack + additional_per_level
	#
	#print("new attack: ", total_attack)
	#
	#return total_attack
	#
#func calculate_critical_chance() -> float:
	#var level = Level.current_level
	#
	#var total_critical_chance = critical_chance + ((Level.stats_per_level["critical_chance"]) * (level - 1))
	#
	#print("new critical chance: ", total_critical_chance)
	#
	#return total_critical_chance
	#
#func calculate_critical_damage() -> float:
	#var level = Level.current_level
	#
	#var total_critical_damage = critical_damage + (Level.stats_per_level["critical_damage"]) * (level - 1)
	#
	#print("new critical damage: ", total_critical_damage)
	#
	#return total_critical_damage
	
func calculate_total_stat(stats: String):
	var level = Level.current_level
	
	var total_by_level = (Level.stats_per_level[stats]) * (level - 1)
	
	print("new total by level: ", total_by_level)
	
	return total_by_level
	
func recalculate_all_stats():
	attack += calculate_total_stat("attack")
	critical_chance += calculate_total_stat("critical_chance")
	critical_damage += calculate_total_stat("critical_damage")
	max_health += calculate_total_stat("max_health")
