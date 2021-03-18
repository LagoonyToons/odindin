extends Node2D



var timer_spawn_max = 3
var timer_spawn = timer_spawn_max
var timer_difficulty = .1
var timer_increment = 1.5
var enemy = preload("res://Scenes/Enemy/Enemy.tscn")
var bouncer = preload("res://Scenes/bouncer/bouncer.tscn")
var mother = preload("res://Scenes/mother/mother.tscn")
var child = preload("res://Scenes/child/child.tscn")
var shooter = preload("res://Scenes/shooter/shooter.tscn")
var bullet = preload("res://Scenes/bullet/bullet.tscn")
var star = preload("res://Scenes/star/star.tscn")
var rng = RandomNumberGenerator.new()
var score = 0

var mother_baby_spawn = 3
var mother_health = 3
var enemy_hp = 1
var bouncer_hp = 2
var shooter_hp = 3
var player_fire_delay = .15
var player_speed = 60
var player_friction = .95
var bullet_penetration = 1
var bullet_speed = 420
var rainbool = true
var scale_factor = Vector2(.5, .5)
var star_count


func _ready():
	rng.randomize()
	open_settings()
	star_count = int(75/(scale_factor.x*scale_factor.x))
	if star_count > 500:
		star_count = 500
	spawn_stars()
	get_node("Player").init(player_fire_delay, player_speed*scale_factor.x, player_friction, bullet_penetration, bullet_speed*scale_factor.x)

func open_settings():
	var config = ConfigFile.new()
	var err = config.load("settings.cfg")
	print(config.has_section_key("set", "scale_factor"))
	mother_baby_spawn = config.get_value("set", "mother_baby_spawn", 3)
	mother_health = config.get_value("set", "mother_health", 3)
	enemy_hp = config.get_value("set", "enemy_hp", 1)
	bouncer_hp = config.get_value("set", "bouncer_hp", 2)
	player_fire_delay = config.get_value("set", "player_fire_delay", .15)
	player_speed = config.get_value("set", "player_speed", 60)
	player_friction = config.get_value("set", "player_friction", .95)
	bullet_penetration = config.get_value("set", "bullet_penetration", 1)
	bullet_speed = config.get_value("set", "bullet_speed", 420)
	rainbool = config.get_value("set", "rainbow_bullets", true)
	var x = config.get_value("set", "scale_factor", 1)
	scale_factor = Vector2(x, x)
		
func spawn_stars():
	for x in range(0,star_count):
		var scene_instance = star.instance()
		scene_instance.set_name("star")
		call_deferred("add_child", scene_instance)
func _process(delta):
	timer_spawn -= delta
	timer_increment -= delta
	if (timer_increment <= 0 and timer_spawn_max > .5):
		timer_spawn_max -= timer_difficulty
		timer_increment = 1
	if (timer_spawn <= 0):
		spawn_enemy()
		timer_spawn = timer_spawn_max
	score += 100*delta
	get_node("Label").text = "collisions: " + str(get_node("Player").collisions) + "\nScore: " + str(int(score))
	
func spawn_enemy():
	var r = rng.randi_range(1, 100)
	var scene_instance
	if r <= 45:
		scene_instance = enemy.instance()
		scene_instance.init(enemy_hp)
	elif r <= 60:
		scene_instance = bouncer.instance()
		scene_instance.init(bouncer_hp)
	elif r <= 80:
		scene_instance = shooter.instance()
		scene_instance.init(shooter_hp)
	else:
		scene_instance = mother.instance()
		scene_instance.init(mother_health)
		scene_instance.baby_count = mother_baby_spawn
	scene_instance.set_name("Enemy")
	call_deferred("add_child", scene_instance)
