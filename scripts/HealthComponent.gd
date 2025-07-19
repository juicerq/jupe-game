extends Node
class_name HealthComponent

@export var max_health: int
var current_health
@export var body = CharacterBody2D

signal died

func _ready():
	current_health = max_health
	
	if not max_health or max_health == 0:
		push_error("No max_health set in ", get_parent().name)
		
func take_damage(amount: int):
	current_health -= amount
	print(get_parent().name, " got damaged for ", amount)
	
	if current_health <= 0:
		died.emit()
		get_parent().queue_free()
