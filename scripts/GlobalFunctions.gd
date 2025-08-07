extends Node

func get_closest_player(body: Node2D):
    var players: Array[Node] = get_tree().get_nodes_in_group("Player")

    if players.is_empty():
        return null

    var closest_player: CharacterBody2D = null

    for player in players:
        if player == null:
            continue

        if closest_player == null:
            closest_player = player
            continue

        var distance_to_player = body.global_position.distance_to(player.global_position)
        var distance_to_closest = body.global_position.distance_to(closest_player.global_position)

        if distance_to_player < distance_to_closest:
            closest_player = player

    return closest_player
	
