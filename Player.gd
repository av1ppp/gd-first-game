extends KinematicBody2D

var SPEED      = 180
var JUMP_FORCE = 400
var GRAVITY    = 750

var vel = Vector2()

onready var viewport_size = get_viewport().size

func _physics_process(delta):
	
	if position.x < 0:
		position.x = viewport_size.x
	elif position.x > viewport_size.x:
		position.x = 0
		
	if position.y < 0:
		position.y = viewport_size.y
	elif position.y > viewport_size.y:
		position.y = 0
	
	if Input.is_action_pressed("player_left"):
		if is_on_floor():
			$AnimatedSprite.play("walk")
		$AnimatedSprite.flip_h = true
		vel.x = -SPEED
	elif Input.is_action_pressed("player_right"):
		if is_on_floor():
			$AnimatedSprite.play("walk")
		$AnimatedSprite.flip_h = false
		vel.x = SPEED
	else:
		if is_on_floor():
			$AnimatedSprite.play("idle")
		
	vel.y += GRAVITY * delta
	
	if Input.is_action_just_pressed("player_jump") and is_on_floor():
		$AnimatedSprite.play("jump")
		vel.y -= JUMP_FORCE
		
	vel = move_and_slide(vel, Vector2.UP)
	vel.x = lerp(vel.x, 0, 0.2)

