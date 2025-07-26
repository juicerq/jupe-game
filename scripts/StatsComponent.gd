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
	
func calculate_total_stat(stats: String):
	var level = Level.current_level
	
	var total_by_level = (Level.stats_per_level[stats]) * (level - 1)
	
	return total_by_level
	
func recalculate_all_stats():
	attack += calculate_total_stat("attack")
	critical_chance += calculate_total_stat("critical_chance")
	critical_damage += calculate_total_stat("critical_damage")
	max_health += calculate_total_stat("max_health")
