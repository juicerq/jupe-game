extends Node
class_name LevelComponent

var ExperiencePerLevelNeeded: Dictionary[int, int] = {
	1: 100,
	2: 200,
	3: 300,
	4: 400,
	5: 500
}

@export var current_level: int = 1
var current_experience: int = 0

# TODO: create different stats for monster and players
var stats_per_level: Dictionary = {
	"attack": 5,
	"health": 5,
	"critical_chance": 5,
	"critical_damage": 5,
	"defense": 5,
	"max_health": 10
}

func add_experience(amount: int) -> bool:
	if not ExperiencePerLevelNeeded.has(current_level):
		print("max level achieved")
		return false
	
	current_experience += amount
	
	var needed_to_level_up = ExperiencePerLevelNeeded[current_level]
	
	if current_experience >= needed_to_level_up:
		var next_level = current_level + 1
		print("player leveled up from: ", current_level, " to: ", next_level)
		current_level = next_level
		
		return true
		
	return false
