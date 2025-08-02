extends Node2D
class_name Experience

@export var exp_area: Area2D
@export var collect_area: Area2D

var experience_amount = 10

var speed = 110
var player: Player

func _ready() -> void:
	exp_area.body_entered.connect(_on_exp_body_entered)
	collect_area.body_entered.connect(_on_collect_body_entered)
	
# entered area to collect exp
func _on_collect_body_entered(body: Node2D):
	if not body is Player: return
	
	if body is Player:
		var leveled_up = body.level_manager.add_experience(experience_amount)
		
		if leveled_up:
			body.stats_manager.recalculate_all_stats()
	
	queue_free()

# entered area of pull exp
func _on_exp_body_entered(body: Node2D) -> void:
	if not body.is_in_group("Player") or player: return
	
	player = body

func _physics_process(delta: float) -> void:
	if not player: return
	
	speed += 2
	
	var direction = (player.global_position - global_position).normalized()
	
	global_position += direction * speed * delta
