extends CharacterBody2D
class_name Player

@export var movement_speed: float = 50
@export var level_manager: LevelComponent
@export var stats_manager: StatsComponent
@export var health_manager: HealthComponent
@export var sprite_manager: AnimatedSprite2D

var character_direction: Vector2

signal player_gained_experience(amount: float, max_experience)

func _physics_process(delta):
	if health_manager.is_dead: return
	
	character_direction.x = Input.get_axis("a", "d")
	character_direction.y = Input.get_axis("w", "s")
	character_direction = character_direction.normalized()
	
	if character_direction.x > 0: sprite_manager.flip_h = false
	elif character_direction.x < 0: sprite_manager.flip_h = true
	
	if character_direction:
		velocity = character_direction * movement_speed
		if sprite_manager.animation != "walk": sprite_manager.animation = "walk"
	else:
		velocity = velocity.move_toward(Vector2.ZERO, movement_speed)
		sprite_manager.animation = "idle"
		
	move_and_slide()


func _on_health_component_died() -> void:
	pass
