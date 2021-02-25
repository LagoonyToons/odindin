extends Node2D


var rng = RandomNumberGenerator.new()
var move_speed
var neg = [-1,1]
onready var vel = Vector2((rng.randf_range(0, 100) * neg[rng.randi_range(0,1)]), (rng.randf_range(0, 100) * neg[rng.randi_range(0,1)])).normalized()
onready var color = $"shape"
var color_max = 45
var color_min = 15
# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	move_speed = rng.randi_range(45, 130)*get_parent().scale_factor.x
	scale = get_parent().scale_factor*rng.randi_range(.50, 1.00)
	position.x = rng.randi_range(0, get_viewport_rect().size.x)
	position.y = rng.randi_range(0, get_viewport_rect().size.y)
	var col = rng.randi_range(color_min, color_max)
	color.modulate = Color8(col, col, col)

func _process(delta):
	var player_vel = get_parent().get_node("Player").vel
	#position += move_speed*delta*vel
	position += (player_vel.normalized() * player_vel.length()/25)*delta*move_speed
	if (position.x > get_viewport_rect().size.x):
		position.x = 0
	elif ( position.x < 0):
		position.x = get_viewport_rect().size.x
	
	if (position.y > get_viewport_rect().size.y):
		position.y = 0
	elif ( position.y < 0):
		position.y = get_viewport_rect().size.y
