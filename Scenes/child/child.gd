extends "res://Scenes/enemy_base/enemy_base.gd"
var pos
func _ready():
	move_speed = rng.randi_range(10, 15)*get_parent().scale_factor.x
	scale = get_parent().scale_factor
	decay = rng.randf_range(0.98, 1.0)
	friction = rng.randf_range(0.1, 1.0)
	position=pos
	score = 69
	#connect("area_entered", self, "_on_bullet_area_entered")

func _process(delta):
	target_player(delta)
	move(delta)
