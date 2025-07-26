extends CharacterBody2D
class_name Arrow

var direction: Vector2
var speed = 300
var damage = 10

func _ready() -> void:
	%ArrowArea.body_entered.connect(_on_body_entered)
	
func _on_body_entered(body):
	if body.is_in_group("Enemies"):
		var body_health = body.get_node("HealthComponent")
		
		if (not body_health): push_error("Enemy with no health component")
		
		body_health.take_damage(damage)
		
		queue_free()

func _physics_process(delta: float) -> void:
	rotation = direction.angle() + PI/2
	move_and_collide(direction * speed * delta)
