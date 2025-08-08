extends Node2D
class_name World

func check_player_dead(player: Player):
	return player.health_component.is_dead and not player.sprite_component.is_playing()

func _physics_process(delta: float) -> void:
	var all_players = get_tree().get_nodes_in_group("Player") as Array[Player]
	
	var is_all_dead = all_players.all(check_player_dead)
	
	if not is_all_dead: return
	
	get_tree().paused = true
	
	return
