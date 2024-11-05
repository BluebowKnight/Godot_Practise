extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.play("moving") # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_timeout():
	if is_instance_valid(self):
		self.queue_free()

func _on_body_entered(body):
	if body.name == "Player":
		$AnimatedSprite2D.play("explode")
		$Timer.start()
