extends CharacterBody2D
class_name Enemy

@export var DamageArea: Area2D
@export var HealthComponent: HealthComponent
@export var Sprite: AnimatedSprite2D
@export var StatsComponent: StatsComponent

@export var speed = 40
var exp_scene = preload("res://scenes/Player/Experience/Experience.tscn")

func _ready() -> void:
	DamageArea.body_entered.connect(_on_body_entered)
	
func _on_body_entered(body):
	if body.is_in_group("Player"):
		var player_health = body.get_node("HealthComponent")
		
		player_health.take_damage(StatsComponent.attack)
	

func _physics_process(delta: float) -> void:
	if HealthComponent.is_dead: return
	
	var players: Array[Node] = get_tree().get_nodes_in_group("Player")
	
	var closest_player: CharacterBody2D 
	
	for player in players:
		if not closest_player: closest_player = player
		
		if not player: pass
		
		var distance_to_player = global_position.distance_to(player.global_position)
		
		if distance_to_player < global_position.distance_to(closest_player.global_position):
			closest_player = player
	
	if not closest_player:
		push_error("No player found in enemy movement")
		return
		
	var direction = (closest_player.global_position - global_position).normalized()
	
	if direction.x > 0: Sprite.flip_h = false
	elif direction.x < 0: Sprite.flip_h = true
		
	if direction:
		velocity = direction * speed
		Sprite.animation = "walk"
	else:
		velocity = Vector2.ZERO
		Sprite.animation = "idle"
	
	move_and_slide()


func _on_health_component_died() -> void:
	remove_from_group("Enemies")
	var spawned_experience = exp_scene.instantiate()
	get_tree().current_scene.add_child(spawned_experience)
	spawned_experience.global_position = global_position
