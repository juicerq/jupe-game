extends Node

func get_closest_player(body: Node2D):
	var players: Array[Node] = get_tree().get_nodes_in_group("Player")
	
	var closest_player: CharacterBody2D 
	
	for player in players:
		if not closest_player: closest_player = player
		
		if not player: return null
		
		var distance_to_player = body.global_position.distance_to(player.global_position)
		
		if distance_to_player < body.global_position.distance_to(closest_player.global_position):
			closest_player = player
	
	return closest_player
	
