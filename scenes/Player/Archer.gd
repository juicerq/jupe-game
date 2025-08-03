extends Player
class_name Archer

var stats_per_level: Dictionary = {
	"attack": 10,
	"health": 5,
	"critical_chance": 5,
	"critical_damage": 5,
	"defense": 5,
	"max_health": 10
}

func _ready() -> void:
	setup_archer_connections()
	
func setup_archer_connections():
	level_component.level_changed.connect(_on_level_up)

func _on_level_up(new_level: int):
	add_level_stats_bonuses(new_level)

func add_level_stats_bonuses(new_level: int):
	var bonuses = {}
	
	for stat_name in stats_per_level:
		bonuses[stat_name] = stats_per_level[stat_name] * (new_level - 1)
		
	stats_component.recalculate_stats_with_bonuses(bonuses)
