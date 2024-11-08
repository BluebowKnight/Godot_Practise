extends CharacterBody2D

#player movement variables

@export var speed = 100.0
@export var gravity = 200.0
@export var jump_height = -100

var last_direction = 0
var current_direction = 0

func _physics_process(delta):
	velocity.y += gravity * delta
	horizontal_movement()
	
	move_and_slide()
	
	if !Global.is_attacking || !Global.is_climbing:
		player_animations()

func horizontal_movement():
	var horizontal_input = Input.get_action_strength('ui_right') - Input.get_action_strength('ui_left')
	velocity.x=horizontal_input*speed
	
#animation
func player_animations():
	if Input.is_action_pressed('ui_left') && Global.is_jumping == false:
		$AnimatedSprite2D.flip_h = true
		$AnimatedSprite2D.play("run")
		$CollisionShape2D.position.x = 7
		
	if Input.is_action_pressed('ui_right') && Global.is_jumping == false:
		$AnimatedSprite2D.flip_h = false
		$AnimatedSprite2D.play("run")
		$CollisionShape2D.position.x = -7
	
	if !Input.is_anything_pressed():
		$AnimatedSprite2D.play("idle")
		
func _input(event):
	if event.is_action_pressed('ui_attack'):
		Global.is_attacking = true
		$AnimatedSprite2D.play('attack')
	
	if event.is_action_pressed("ui_jump") and is_on_floor():
		velocity.y = jump_height
		$AnimatedSprite2D.play("jump")
		
	if Global.is_climbing == true:
		if Input.is_action_pressed("ui_up"):
			$AnimatedSprite2D.play("climb")
			gravity = 100
			velocity.y = -200
			Global.is_jumping = true
		
	else:
		gravity = 200
		Global.is_climbing = false
		Global.is_jumping = false

func _on_animated_sprite_2d_animation_finished():
	Global.is_attacking = false # Replace with function body.
	Global.is_climbing = false
