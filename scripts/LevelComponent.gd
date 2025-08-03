extends Node
class_name LevelComponent

@export var player: Player = null

@export var current_level: int = 1
var current_experience: float = 0

var max_experience: float = 200
var max_experience_increase_per_level: int = 20 # percentage

signal level_changed(new_level: int)

# TODO: create different stats for monster and players
var stats_per_level: Dictionary = {
	"attack": 5,
	"health": 5,
	"critical_chance": 5,
	"critical_damage": 5,
	"defense": 5,
	"max_health": 10
}

func update_max_experience():
	if current_level == 1:
		return
	
	var new_max_experience = max_experience + ((max_experience * max_experience_increase_per_level / 100) * (current_level - 1))
	
	max_experience = new_max_experience
	
	return

func handle_level_up():
	update_max_experience()

func add_experience(amount: float) -> void:
	current_experience += amount
	
	var should_level_up = current_experience >= max_experience
	
	#print("[EXP] current_experience is ", current_experience, " and max is ", max_experience )
	
	if should_level_up:
		var next_level = current_level + 1
		
		#print("[EXP]: player level up from ", current_level, " to ", next_level)
		
		current_level = next_level
		current_experience = max(0, current_experience - max_experience)
		
		handle_level_up()
	
	if (player):
		player.player_gained_experience.emit(current_experience, max_experience)
