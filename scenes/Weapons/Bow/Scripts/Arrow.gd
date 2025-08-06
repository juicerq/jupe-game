extends CharacterBody2D
class_name Arrow

var direction: Vector2
var speed = 300
var damage = 10

func _ready() -> void:
	%ArrowArea.body_entered.connect(_on_body_entered)
	
func _on_body_entered(body: Node2D):
	if body is Enemy:
		body.HealthComponent.take_damage(damage)
		
		queue_free()

func _physics_process(delta: float) -> void:
	rotation = direction.angle() + PI/2
	move_and_collide(direction * speed * delta)
