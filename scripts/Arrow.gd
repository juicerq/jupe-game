extends CharacterBody2D

var enemy_direction: Vector2
var speed = 200

func _ready() -> void:
	%ArrowArea.body_entered.connect(_on_body_entered)
	
func _on_body_entered(body):
	if body.is_in_group("Enemies"):
		queue_free()

func set_direction(direction: Vector2):
	if enemy_direction: return
	
	enemy_direction = direction

func _physics_process(delta: float) -> void:
	velocity = enemy_direction * speed
	move_and_slide()
	
	var collision = get_last_slide_collision()
	
	print(collision)
	
	if not collision: return
	
	var collider = collision.get_collider()
	
	if collider.is_in_group("Enemies"):
		queue_free()

		
