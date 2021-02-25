extends "res://Scenes/enemy_base/enemy_base.gd"

func _ready():
	move_speed = rng.randi_range(6, 14)*get_parent().scale_factor.x
	scale = get_parent().scale_factor
	decay = rng.randf_range(0.98, 1.0)
	friction = rng.randf_range(0.1, 1.0)	
	score = 200	
	
func _process(delta):
	target_player(delta)
	move(delta)
