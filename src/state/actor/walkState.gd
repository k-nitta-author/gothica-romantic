class_name WalkState
extends MoveState

func enter_state():
	state_actor.anim.play("walk")
	state_actor.stateLabel.text = "walk"

	state_actor.is_shooting = false
	state_actor.is_attacking = false

func update():

	state_actor.walk()

	state_actor.velocity.y += state_actor.speed_in_air_vertical    

	if state_actor.velocity.x == 0: state_actor.selected_state = BaseActor.STATES.IDLE

	if !state_actor.is_on_floor(): state_actor.selected_state = BaseActor.STATES.FALLLING

func handle_input():

	state_actor.walk()

	if Input.is_action_pressed("jump"):
		state_actor.velocity.y -= state_actor.jump_force
		state_actor.selected_state = BaseActor.STATES.JUMPING

	if Input.is_action_pressed("duck"):
		state_actor.is_ducking = true
		state_actor.selected_state = BaseActor.STATES.IDLE
