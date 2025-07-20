extends Node
class_name HealthComponent

var current_health
var is_dead: bool = false
@export var body = CharacterBody2D

signal died

func _ready():
	if not %StatsComponent.max_health or %StatsComponent.max_health == 0:
		push_error("No max_health set in ", get_parent().name)
	
	current_health = %StatsComponent.max_health

func take_damage(amount: int):
	if is_dead: return
	
	current_health -= amount
	print(get_parent().name, " got damaged for ", amount)
	
	if current_health <= 0:
		die()
		return
		
		
func _on_animation_finished():
	get_parent().queue_free()
	
func die():
		is_dead = true
		died.emit()
		%Sprite.play("die")
		%Sprite.animation_finished.connect(_on_animation_finished)
