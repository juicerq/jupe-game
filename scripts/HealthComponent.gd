extends Node
class_name HealthComponent

@export var Stats: StatsComponent
@export var Sprite: AnimatedSprite2D
@export var Collision: CollisionShape2D

var current_health
var is_dead: bool = false

signal died

func _ready():
	current_health = Stats.max_health

func take_damage(amount: int):
	var total_damage = (amount - (amount * Stats.defense / 100))
	print(get_parent().name, " DAMAGED! HP before: ", current_health, ".", " after: ", current_health - total_damage)
	current_health -= total_damage
	
	if current_health <= 0:
		die()
		return
		
		
func _on_animation_finished():
	get_parent().queue_free()
	
func die():
	died.emit()
	Collision.queue_free()
	Sprite.play("die")
	is_dead = true
	Sprite.animation_finished.connect(_on_animation_finished)
