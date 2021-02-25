extends "res://Scenes/enemy_base/enemy_base.gd"


func _ready():
	var neg = [1, -1]
	#connect("area_entered", self, "_on_bullet_area_entered")
	move_speed = rng.randi_range(350, 500)*get_parent().scale_factor.x
	scale = get_parent().scale_factor
	vel = Vector2((rng.randf_range(0, 100) * neg[rng.randi_range(0,1)]), (rng.randf_range(0, 100) * neg[rng.randi_range(0,1)])).normalized()
	hp = 2
	score = 300

func _process(delta):
	position += vel*move_speed*delta

	if (position.x > get_viewport_rect().size.x) or position.x < 0:
		position.x -= vel.x
		vel.x *= -friction
	
	if (position.y > get_viewport_rect().size.y) or position.y < 0:
		position.y -= vel.y
		vel.y *= -friction
