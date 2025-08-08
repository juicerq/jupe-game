extends Weapon
class_name Bow

var arrow_scene = preload("res://scenes/Weapons/Bow/Arrow.tscn")

@onready var AttackStartPosition: Marker2D = $%AttackStartPosition
@onready var AttackTimer: Timer = $AttackTimer

func attack():
	var arrow: Arrow = arrow_scene.instantiate()
	
	get_tree().current_scene.add_child(arrow)
	
	arrow.damage = get_damage()
	
	arrow.global_position = AttackStartPosition.global_position
	
	arrow.direction = (get_global_mouse_position() - global_position).normalized()
