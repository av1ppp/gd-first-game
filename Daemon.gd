extends KinematicBody2D


const SPEED = 100
const GRAVITY = 750

var velocity = Vector2()
var direction = -1

func set_direction(direction_: int):
	if direction_ == -1:
		$AnimatedSprite.play("walk")
		$AnimatedSprite.flip_h = true
	elif direction_ == 1:
		$AnimatedSprite.play("walk")
		$AnimatedSprite.flip_h = false
	elif direction_ == 0:
		$AnimatedSprite.play("idle")	
	else:
		return
		
	direction = direction_

func _ready():
	set_direction(0)
	
onready var player = get_node(@"/root/Main/Player")

func distance_to(target_node):
	var a = Vector2(target_node.get_pos() - $".".get_pos())
	return sqrt((a.x * a.x) + (a.y * a.y))

func _physics_process(delta):
	var a = Vector2(player.position - position)
	var dist = sqrt((a.x * a.x) + (a.y * a.y))
	
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		if collision.collider.name == "Player":
			print("Попался!")
	
	if dist < 250:
		if a.x > 0:
			set_direction(1)
		else:
			set_direction(-1)
	else:
		set_direction(0)
	
	velocity.x = SPEED * direction
	velocity.y += GRAVITY * delta
	velocity = move_and_slide(velocity, Vector2.UP)
