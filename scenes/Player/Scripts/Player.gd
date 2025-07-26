extends CharacterBody2D
class_name Player

@export var movement_speed: float = 50
@export var level_manager: LevelComponent
@export var stats_manager: StatsComponent
var character_direction: Vector2

func _physics_process(delta):
	if %HealthComponent.is_dead: return
	
	character_direction.x = Input.get_axis("a", "d")
	character_direction.y = Input.get_axis("w", "s")
	character_direction = character_direction.normalized()
	
	if character_direction.x > 0: %Sprite.flip_h = false
	elif character_direction.x < 0: %Sprite.flip_h = true
	
	if character_direction:
		velocity = character_direction * movement_speed
		if %Sprite.animation != "walk": %Sprite.animation = "walk"
	else:
		velocity = velocity.move_toward(Vector2.ZERO, movement_speed)
		%Sprite.animation = "idle"
		
	move_and_slide()


func _on_health_component_died() -> void:
	pass
