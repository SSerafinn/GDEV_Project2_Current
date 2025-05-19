extends CharacterBody2D


const SPEED = 180
const JUMP_VELOCITY = -450
const GRAVITY = 1800
@onready var animated_sprite_2d = $AnimatedSprite2D


func _physics_process(delta):
	if is_on_floor() == false:
		velocity.y += GRAVITY * delta
		
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y += JUMP_VELOCITY
		
	var direction = Input.get_axis("Left","Right")
	if direction != 0:
		velocity.x = direction * SPEED
	else:
		velocity.x = 0
		
	move_and_slide()
	
