extends CharacterBody2D
class_name Player

@export var movement_speed: float = 50
@onready var level_component: LevelComponent = $LevelComponent
@onready var stats_component: StatsComponent = $StatsComponent
@onready var health_component: HealthComponent = $HealthComponent
@onready var sprite_component: AnimatedSprite2D = $Sprite

var character_direction: Vector2

signal player_gained_experience(amount: float, max_experience)

func _physics_process(delta):
	if health_component.is_dead: return
	
	character_direction.x = Input.get_axis("a", "d")
	character_direction.y = Input.get_axis("w", "s")
	character_direction = character_direction.normalized()
	
	if character_direction.x > 0: sprite_component.flip_h = false
	elif character_direction.x < 0: sprite_component.flip_h = true
	
	if character_direction:
		velocity = character_direction * movement_speed
		if sprite_component.animation != "walk": sprite_component.animation = "walk"
	else:
		velocity = velocity.move_toward(Vector2.ZERO, movement_speed)
		sprite_component.animation = "idle"
		
	move_and_slide()

func take_damage(amount: int):
	var final_damage = stats_component.calculate_damage_after_defense(amount)
	health_component.take_damage(final_damage)

func _on_health_component_died() -> void:
	set_physics_process(false)
