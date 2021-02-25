extends Area2D

var vel = Vector2(0,0)
var MOVE_SPEED
var time_since_bullet = 0
var cooldown
var friction
var collisions = 0
var bullet_penetration
var bullet_speed
var mobile_joy = Vector2(0,0)
var mobile_dir = Vector2(0,0)
var mobile_shoot_joy = Vector2(0,0)
var mobile_shoot_dir = Vector2(0,0)

#onready var bullet = get_node("/root/main/bullet_container/bullet")
onready var bullet = get_parent().bullet
onready var bullet_container = get_parent().get_node("bullet_container")

func init(pfd, ps, pf, bp, bs):
	cooldown = pfd
	MOVE_SPEED = ps
	friction = pf
	bullet_penetration = bp
	bullet_speed = bs
	scale = get_parent().scale_factor
	
func _input(event):
	if event is InputEventScreenTouch:
		if event.position.x < get_viewport().size.x/2.0:
			if event.pressed:
				mobile_joy = event.position
		else:
			if event.pressed:
				Input.action_press("Player_shoot")
				mobile_shoot_dir = event.position
			else:
				Input.action_release("Player_shoot")
	elif event is InputEventScreenDrag:
		if event.position.x < get_viewport().size.x/2.0:
			mobile_dir =  (event.position - mobile_joy).normalized()
		else:
			mobile_shoot_dir = (event.position - mobile_joy).normalized()
			
func _process(delta):
	var which = get_name()	
	# move up and down based on input
	if Input.is_action_pressed(which+"_up"):
		vel.y -= MOVE_SPEED * delta
	if Input.is_action_pressed(which+"_down") :
		vel.y += MOVE_SPEED * delta
	if Input.is_action_pressed(which+"_left") :
		vel.x -= MOVE_SPEED * delta
	if Input.is_action_pressed(which+"_right"):
		vel.x += MOVE_SPEED * delta
	if (Input.is_action_pressed(which+"_shoot") and time_since_bullet <= 0):
		time_since_bullet = cooldown
		spawn_bullet()
		
		
	if (time_since_bullet > 0):
		time_since_bullet -= delta
	
	position += vel
	
	if (position.x > get_viewport_rect().size.x):
		position.x = 0
	elif ( position.x < 0):
		position.x = get_viewport_rect().size.x
	
	if (position.y > get_viewport_rect().size.y):
		position.y = 0
	elif ( position.y < 0):
		position.y = get_viewport_rect().size.y
		
	vel *= friction
	#print(vel_x, vel_y)
	
func spawn_bullet():
	var b = bullet.instance()
	if (mobile_shoot_dir == Vector2(0,0)):
		var direction = (get_viewport().get_mouse_position()-position).normalized()
		b.init(bullet_penetration, bullet_speed, direction, get_parent().rainbool)
	else:
		b.init(bullet_penetration, bullet_speed, mobile_shoot_dir, get_parent().rainbool)
	b.position = position
	bullet_container.add_child(b)
	


func _on_Player_area_entered(area):
	if "Enemy" in area.get_name():  
		collisions += 1
		get_parent().score -= 1000
