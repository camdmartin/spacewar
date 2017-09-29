extends Area2D

var screen_size = Vector2()
var pos = Vector2()
var velocity = Vector2()
var acceleration = Vector2()
var rotation = 0

export var rotation_speed = PI/2
export var engine_thrust = 100
export var maximum_velocity = 1000

func _ready():
	screen_size = get_viewport_rect().size
	pos = screen_size / 2
	set_pos(pos)
	set_process(true)

func _process(delta):
	if Input.is_action_pressed("player_left"):
		rotation += rotation_speed * delta
	if Input.is_action_pressed("player_right"):
		rotation -= rotation_speed * delta
	
	if Input.is_action_pressed("forward_thrust"):
		acceleration = Vector2(engine_thrust, 0).rotated(rotation)
	elif Input.is_action_pressed("reverse_thrust"):
		acceleration = Vector2(engine_thrust, 0).rotated(rotation - PI/2)
	else:
		acceleration = Vector2(0, 0)
	
	if Input.is_action_pressed("anchor_ship"):
		acceleration = Vector2(0, 0)
		velocity = Vector2(0, 0)
		pos = screen_size / 2
	velocity += acceleration * delta
	pos += velocity * delta
	
	set_pos(pos)
	set_rot(rotation - PI/2)