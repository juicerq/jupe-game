extends Player
class_name Archer

var stats_per_level: Dictionary = {
	"max_health": 30,
	"attack": 10,
	"critical_chance": 0,
	"critical_damage": 0,
	"defense": 5
}

func _ready() -> void:
	_setup_archer_connections()
	_add_level_stats_bonuses(level_component.current_level)
	
func _setup_archer_connections():
	level_component.level_changed.connect(_on_level_up)

func _on_level_up(new_level: int):
	_add_level_stats_bonuses(new_level)

func _add_level_stats_bonuses(new_level: int):
	var bonuses = {}
	
	for stat_name in stats_per_level:
		bonuses[stat_name] = stats_per_level[stat_name] * (new_level - 1)
		
	stats_component.recalculate_stats_with_bonuses(bonuses)
