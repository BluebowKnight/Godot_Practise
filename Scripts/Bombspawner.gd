extends Node2D


# Called when the node enters the scene tree for the first time.
var bomb = preload("res://Scenes/Bomb.tscn")

var current_scene_path
var bomb_path
var bomb_animation

func _ready():
	$AnimatedSprite2D.play("cannon_idle")
	current_scene_path = "/root/" + Global.current_scene_name+ "/"
	bomb_path = get_node(current_scene_path+"/BombPath/Path2D/PathFollow2D")
	bomb_animation = get_node(current_scene_path + "/BombPath/Path2D/AnimationPlayer")
	
	bomb_animation.play("bomb_movement")
	
func shoot():
	$AnimatedSprite2D.play("cannon_fired")
	Global.is_bomb_moving = true
	bomb_animation.play("bomb_movement")
	var spawned_bomb = bomb.instantiate()
	return spawned_bomb


func _on_timer_timeout() -> void:
	$AnimatedSprite2D.play("cannon_idle")
	if bomb_path.get_child_count() <=0:
		bomb_path.add_child(shoot())
	if Global.is_bomb_moving == false:
		for bombs in bomb_path.get_children():
			bomb_path.remove_child(bombs)
			bombs.queue_free()
			bomb_animation.stop()
