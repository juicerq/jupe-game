extends CharacterBody2D

@export var speed = 20

func _ready() -> void:
	%EnemyArea.body_entered.connect(_on_body_entered)
	
func _on_body_entered(body):
	if body.is_in_group("Player"):
		var player_health = body.get_node("HealthComponent")
		
		if not player_health: push_error("Player with no health component")
		
		player_health.take_damage(%StatsComponent.attack)
	

func _physics_process(delta: float) -> void:
	if %HealthComponent.is_dead: return
	
	var player: CharacterBody2D = get_tree().get_first_node_in_group("Player")
	
	if not player:
		push_error("Player not found in enemy movement")
		return
		
	var direction = (player.global_position - global_position).normalized()
		
	velocity = direction * speed
	
	move_and_slide()
