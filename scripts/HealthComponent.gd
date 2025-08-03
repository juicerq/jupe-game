extends Node
class_name HealthComponent

@export var max_health: int = 100
var current_health: int = max_health
var is_dead: bool = false

signal died
signal health_changed(current: int, max: int)

func _ready():
	current_health = max_health

func take_damage(amount: int):
	current_health -= amount
	
	if current_health <= 0 and not is_dead:
		died.emit()
		return
