extends CharacterBody2D

var enemy_direction: Vector2
var speed = 500
var damage = 10

func _ready() -> void:
	%ArrowArea.body_entered.connect(_on_body_entered)
	
func _on_body_entered(body):
	if body.is_in_group("Enemies"):
		var body_health = body.get_node("HealthComponent")
		
		if (not body_health): push_error("Enemy with no health component")
		
		body_health.take_damage(damage)
		
		queue_free()

func set_direction(direction: Vector2):
	if enemy_direction: return
	
	enemy_direction = direction

func _physics_process(_delta: float) -> void:
	velocity = enemy_direction * speed
	rotation = enemy_direction.angle() + PI/2
	move_and_slide()
