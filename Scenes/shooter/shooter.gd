extends "res://Scenes/enemy_base/enemy_base.gd"

var BULLET_TIMER = 1.2
var bullet_counter = BULLET_TIMER
onready var bullet = get_parent().bullet
var TARGET_DISTANCE = 200

var line_to_player

func _ready():
	move_speed = rng.randi_range(150, 200)*get_parent().scale_factor.x
	scale = get_parent().scale_factor
	decay = 1
	friction = 1	
	score = 500
	TARGET_DISTANCE *= get_parent().scale_factor.x
	
func _process(delta):
	if bullet_counter <= 0:
		shoot()
		bullet_counter = BULLET_TIMER
	bullet_counter -= delta
	
	target = get_parent().get_node("Player").position
	
	#approach player in a straight line but aim for TARGET_DISTANCE away
	line_to_player = target-position
	if line_to_player.length() > TARGET_DISTANCE and not (-(line_to_player.normalized()*delta*move_speed).length()+line_to_player.length() < TARGET_DISTANCE): 
		position += line_to_player.normalized()*delta*move_speed
	elif line_to_player.length() < TARGET_DISTANCE and not ((line_to_player.normalized()*delta*move_speed).length()+line_to_player.length() > TARGET_DISTANCE):
		position += -1 * line_to_player.normalized()*delta*move_speed

func shoot():
	var b = bullet.instance()
	b.init(1, 275*get_parent().scale_factor.x, (target-position).normalized(), false)
	b.set_name("Enemy")
	b.position = position
	get_parent().find_node("bullet_container").add_child(b)
