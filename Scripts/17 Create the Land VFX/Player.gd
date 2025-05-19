extends CharacterBody2D


const SPEED = 170
const JUMP_VELOCITY = -450
const GRAVITY = 1800
@onready var animated_sprite_2d = $AnimatedSprite2D

var AirborneLastFrame = false


func _ready():
	GameManager.player = self
	GameManager.playerOriginalPos = position

func _process(delta):
	UpdateAnimation()


func _physics_process(delta):
	if is_on_floor() == false:
		velocity.y += GRAVITY * delta
		AirborneLastFrame = true
	elif  AirborneLastFrame:
		PlayLandVFX()
		AirborneLastFrame = false
		
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y += JUMP_VELOCITY
		PlayJumpUpVFX()
		
	var direction = Input.get_axis("Left","Right")
	if direction != 0:
		velocity.x = direction * SPEED
	else:
		velocity.x = 0
	
	if Input.is_action_just_pressed("Down") && is_on_floor():
		position.y += 3
		
	move_and_slide()


func UpdateAnimation():
	if velocity.x != 0:
		animated_sprite_2d.flip_h = velocity.x < 0
		
	if is_on_floor():
		if abs(velocity.x) >= 0.1:
			animated_sprite_2d.play("Run")
		else:
			animated_sprite_2d.play("Idle")
	else:
		animated_sprite_2d.play("Jump")		
			

func PlayJumpUpVFX():
	var vfxToSpawn = preload("res://Game/Scene/vfx_jump_up.tscn")
	GameManager.SpawnVFX(vfxToSpawn,global_position)
	
	
func PlayLandVFX():
	var vfxToSpawn = preload("res://Game/Scene/vfx_land.tscn")	
	GameManager.SpawnVFX(vfxToSpawn,global_position)
	
	
	
	
	



