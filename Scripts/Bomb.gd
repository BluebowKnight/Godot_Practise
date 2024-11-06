extends Area2D

var rotation_speed = 10
# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.play("moving") # Replace with function body.

func _on_timer_timeout():
	if is_instance_valid(self):
		self.queue_free()

func _on_body_entered(body):
	if body.name == "Player":
		$AnimatedSprite2D.play("explode")
		$Timer.start()
		Global.is_bomb_moving = false
		
	if body.name == "Wall":
		$AnimatedSprite2D.play("explode")
		$Timer.strat()
		Global.is_bomb_moving = false
		
func _physics_process(delta):
	if Global.is_bomb_moving == true:
		$AnimatedSprite2D.rotation += rotation_speed * delta
