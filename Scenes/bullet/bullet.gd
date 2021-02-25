extends Area2D


var speed
var direction
var pierce
var change_amount = 750
onready var color = $"Polygon2D"
var do_rainbow
var color_cap = 220
var color_min = 50

var r = 0
var g = 0
var b = color_cap

func init(bp, bs, dir, rainbool):
	pierce = bp
	speed = bs
	direction = dir
	do_rainbow = rainbool

func _ready():
	scale = get_parent().get_parent().scale_factor
func _process(delta):
	position += direction*delta*speed
	if do_rainbow:
		rainbow(delta)
	
	if (position.x > get_viewport_rect().size.x or position.x < 0 or position.y > get_viewport_rect().size.y or position.y < 0):
		queue_free()

func rainbow(delta):
	if r <= color_cap and g >= color_cap and b == color_min and r > color_min:
		r -= ceil(change_amount*delta)
	elif g <= color_cap and b >= color_cap and r == color_min and g > color_min:
		g -= ceil(change_amount*delta)
	elif b <= color_cap and r >= color_cap and g == color_min and b > color_min:
		b -= ceil(change_amount*delta)
	elif r >= color_cap and g <= color_cap and b == color_min:
		g += ceil(change_amount*delta)
	elif g >= color_cap and b <= color_cap and r == color_min:
		b += ceil(change_amount*delta)
	elif b >= color_cap and r <= color_cap and g == color_min:
		r += ceil(change_amount*delta)
	r = color_bound_check(r)
	g = color_bound_check(g)
	b = color_bound_check(b)

	color.modulate = Color8(r, g, b)
	
func color_bound_check(c):
	if c > color_cap:
		c=color_cap
	if c < color_min:
		c=color_min
	return c

func _on_bullet_area_entered(area):
	if "Enemy" in area.get_name() and "bullet" in name: 
		collide()
	elif "Player" in area.get_name() and "Enemy" in name:
		collide()
	elif "bullet" in area.get_name() and "Enemy" in name:
		collide()
func collide():
	pierce -= 1
	if pierce == 0:
		queue_free()
