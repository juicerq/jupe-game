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
	#print(get_parent().name, " DAMAGED! HP before: ", current_health, " -", " after: ", current_health - total_damage)
	current_health -= total_damage
	
	if current_health <= 0:
		die()
		return
		

func die():
	Collision.queue_free()
	is_dead = true
	Sprite.play("die")
	await Sprite.animation_finished
	died.emit()
	get_parent().queue_free()
