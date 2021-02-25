extends Area2D

var vel = Vector2(0,0)
var acceleration = Vector2(0,0)
var target = Vector2(0,0)

var rng = RandomNumberGenerator.new()

var move_speed
var decay = 1
var friction = 1
var hp
var score

func init(health):
	hp = health

func _ready():
	rng.randomize()
	if (rng.randi_range(0,1)):
		#y is 0 or max
		position.y = rng.randi_range(0,1)*get_viewport_rect().size.y
		#x is between 0 and max
		position.x = rng.randi_range(0, get_viewport_rect().size.x)
	else:
		#x is between 0 and max
		position.x = rng.randi_range(0,1)*get_viewport_rect().size.x
		#y is 0 or max
		position.y = rng.randi_range(0, get_viewport_rect().size.y)

func target_player(delta):
	target = get_parent().get_node("Player").position
	acceleration = (target-position).normalized()*delta*move_speed
	
func move(delta):
	if (position.x > get_viewport_rect().size.x) or position.x < 0:
		position.x -= vel.x
		vel.x *= -friction
	
	if (position.y > get_viewport_rect().size.y) or position.y < 0:
		position.y -= vel.y
		vel.y *= -friction
	
	vel += acceleration
	position += vel
	
	vel *= decay

func _on_Enemy_area_entered(area):
	if "bullet" in area.get_name() or "Player" in area.get_name():
		hp -= 1
		if hp <= 0:
			get_parent().score += score
			queue_free()
