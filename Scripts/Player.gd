extends CharacterBody2D

#player movement variables

@export var speed = 100.0
@export var gravity = 200.0
@export var jump_height = -100

var is_attacking = false
var is_climbing = false

func _physics_process(delta):
	velocity.y += gravity * delta
	horizontal_movement()
	
	move_and_slide()
	if !is_attacking:
		player_animations()

func horizontal_movement():
	var horizontal_input = Input.get_action_strength('ui_right') - Input.get_action_strength('ui_left')
	velocity.x=horizontal_input*speed
	
#animation
func player_animations():
	if Input.is_action_pressed('ui_left') || Input.is_action_just_released('ui_jump'):
		$AnimatedSprite2D.flip_h = true
		$AnimatedSprite2D.play("run")
		
	if Input.is_action_pressed('ui_right') || Input.is_action_just_released('ui_jump'):
		$AnimatedSprite2D.flip_h = false
		$AnimatedSprite2D.play("run")
	
	if !Input.is_anything_pressed():
		$AnimatedSprite2D.play("idle")
		
func _input(event):
	if event.is_action_pressed('ui_attack'):
		is_attacking = true
		$AnimatedSprite2D.play('attack')
	
	if event.is_action_pressed("ui_jump") and is_on_floor():
		$AnimatedSprite2D.play("jump")
		
	if is_climbing == true:
		$AnimatedSprite2D.play("climb")
		gravity = 100
		velocity.y = -200
		
	else:
		gravity = 200
		is_climbing = false

'
const SPEED = 100.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
#var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()'


func _on_animated_sprite_2d_animation_finished():
	is_attacking = false # Replace with function body.
