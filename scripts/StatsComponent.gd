extends Node
class_name StatsComponent

@export var base_max_health: int
@export var base_attack: int
@export var base_critical_chance: float
@export var base_critical_damage: float
@export var base_defense: int

var max_health: int
var attack: int
var critical_chance: float
var critical_damage: float
var defense: int

signal stats_changed

func _ready() -> void:
	recalculate_stats_with_bonuses({})
	
func recalculate_stats_with_bonuses(bonus_stats: Dictionary):
	max_health = base_max_health + bonus_stats.get("max_health", 0)
	attack = base_attack + bonus_stats.get("attack", 0)
	critical_chance = base_critical_chance + bonus_stats.get("critical_chance", 0.0)
	critical_damage = base_critical_damage + bonus_stats.get("critical_damage", 0.0)
	defense = base_defense + bonus_stats.get("defense", 0)
	
func calculate_damage_after_defense(damage_amount: int):
	return max(1, damage_amount - (damage_amount * defense / 100))
