extends CharacterBody2D
class_name Enemy

@onready var DamageArea: Area2D = $DamageArea
@onready var HealthComponent: HealthComponent = $HealthComponent
@onready var Sprite: AnimatedSprite2D = $Sprite
@onready var StatsComponent: StatsComponent = $StatsComponent
@onready var Collision: CollisionShape2D = $Collision
@onready var LevelComponent: LevelComponent = $LevelComponent

@export var speed = 40
@export var experience_drop: float

var exp_scene = preload("res://scenes/Enemy/Experience/Experience.tscn")

var stats_per_level: Dictionary = {
	"attack": 5,
	"health": 5,
	"critical_chance": 2,
	"critical_damage": 2,
	"defense": 2,
	"max_health": 10
}

func _setup_signals_connections():
	HealthComponent.health_changed.connect(_on_health_changed)
	HealthComponent.died.connect(_on_health_died)
	LevelComponent.level_changed.connect(_on_level_up)
	DamageArea.body_entered.connect(_on_body_entered)

func _ready() -> void:
	_setup_signals_connections()
	_add_level_stats_bonuses(LevelComponent.current_level)

func _physics_process(delta: float) -> void:
	if HealthComponent.is_dead: return
	
	var closest_player = GlobalFunctions.get_closest_player(self)
	
	if not closest_player:
		Sprite.play("idle")
		return
		
	var direction = (closest_player.global_position - global_position).normalized()
	
	if direction.x > 0: Sprite.flip_h = false
	elif direction.x < 0: Sprite.flip_h = true
		
	if direction:
		velocity = direction * speed
		move_and_collide(velocity * delta)
		Sprite.play("walk")
	else:
		move_and_collide(Vector2.ZERO)
		Sprite.play("idle")

func _drop_experience():
	var spawned_experience: Experience = exp_scene.instantiate()
	get_tree().current_scene.add_child(spawned_experience)
	spawned_experience.experience_amount = experience_drop
	spawned_experience.global_position = global_position
	
# --- SIGNALS --- #
func _on_health_changed():
	Sprite.play("hurt")

func _on_body_entered(body):
	if body.is_in_group("Player") and not HealthComponent.is_dead:
		if body is Player:
			body.take_damage(StatsComponent.attack)

func _on_health_died() -> void:
	Collision.disabled = true
	remove_from_group("Enemies")
	_drop_experience()
	Sprite.play("death")
	await Sprite.animation_finished
	queue_free()

func _on_level_up(new_level: int):
	_add_level_stats_bonuses(new_level)

func _add_level_stats_bonuses(new_level: int):
	var bonuses = {}
	for stat_name in stats_per_level:
		bonuses[stat_name] = stats_per_level[stat_name] * (new_level - 1)

	StatsComponent.recalculate_stats_with_bonuses(bonuses)
	HealthComponent.max_health = StatsComponent.max_health
