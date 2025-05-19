extends CharacterBody2D

const SPEED = 50
var direction = -1
@onready var animated_sprite_2d = $AnimatedSprite2D


func _process(delta):
	UpdateAnimation()

func _physics_process(delta):
	if is_on_floor() == false:
		velocity.y = 300
		
	velocity.x = direction * SPEED
	
	move_and_slide()
	
func UpdateAnimation():
	if velocity.x != 0:
		animated_sprite_2d.flip_h = velocity.x > 0
		
	animated_sprite_2d.play("Walk")
