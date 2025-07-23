extends Node
class_name HealthComponent

@export var max_health: int
@export var Stats: StatsComponent
@export var Sprite: AnimatedSprite2D
@export var Collision: CollisionShape2D

var current_health
var is_dead: bool = false

signal died

func _ready():
	current_health = max_health + (max_health * 100) / 100

func take_damage(amount: int):
	print(get_parent().name, " HP before damage: ", current_health)
	current_health -= (amount - (amount * Stats.defense / 100))
	print(get_parent().name, " got damaged for ", amount, " and the HP now is ", current_health)
	
	if current_health <= 0:
		die()
		return
		
		
func _on_animation_finished():
	get_parent().queue_free()
	
func die():
	died.emit()
	Collision.disabled = true
	Sprite.play("die")
	is_dead = true
	Sprite.animation_finished.connect(_on_animation_finished)
