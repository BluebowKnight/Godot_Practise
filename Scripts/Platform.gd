extends Area2D

enum State{WAIT_AT_BOTTOM, MOVING_UP,WAIT_AT_TOP,MOVING_DOWN}

var current_state = State.WAIT_AT_BOTTOM

var initial_position

func _on_timer_timeout():
	if current_state == State.WAIT_AT_TOP:
		switch_state(State.MOVING_DOWN)
		
	if current_state == State.WAIT_AT_BOTTOM:
		switch_state(State.MOVING_UP)
		

func _ready():
	initial_position = position.y
	switch_state(State.MOVING_UP)
