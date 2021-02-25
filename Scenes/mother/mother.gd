extends "res://Scenes/enemy_base/enemy_base.gd"

var baby_count	


func _ready():
	move_speed = rng.randi_range(3, 6)*get_parent().scale_factor.x
	scale = get_parent().scale_factor
	decay = .995
	friction = 0	
	hp = 3
	score = 1000

func _process(delta):
	target_player(delta)
	move(delta)
	rotate(.025*decay*(abs(vel.x)+abs(vel.y)*get_parent().scale_factor.x))
	
func _on_Enemy_area_entered(area):
	if "bullet" in area.get_name() or "Player" in area.get_name():
		hp -= 1
		var scene_instance
		if hp <= 0:
			for n in baby_count:
				scene_instance = get_parent().child.instance()
				scene_instance.set_name("Enemy")
				scene_instance.init(1)
				scene_instance.pos = Vector2(rng.randi_range(position.x-50, position.x+50), rng.randi_range(position.y-50, position.y+50))
				get_parent().call_deferred("add_child", scene_instance)
			queue_free()
