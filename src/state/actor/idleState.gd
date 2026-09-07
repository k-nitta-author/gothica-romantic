class_name IdleState
extends ActorState

func enter_state():
	state_actor.stateLabel.text = "idle"
	state_actor.is_attacking = false
	state_actor.is_shooting = false

func exit_state() -> void:
	state_actor.cease_attack()

func update():

	state_actor.velocity.y += state_actor.speed_in_air_vertical

	if abs(state_actor.velocity.x) > 0: state_actor.selected_state = BaseActor.STATES.MOVING

func handle_input():

	if Input.is_action_pressed("duck"):
		state_actor.is_ducking = true
		state_actor.anim.play("duck")
		state_actor.selected_state = BaseActor.STATES.DUCKING

	elif Input.is_action_pressed("attack"):
		state_actor.attack()
		state_actor.anim.play("attack")

	elif Input.is_action_pressed("shoot"):
		state_actor.anim.play("shoot")

	if Input.is_action_pressed("move_left", true) or Input.is_action_pressed("move_right", true):
		state_actor.selected_state = BaseActor.STATES.MOVING

	if Input.is_action_pressed("jump"):
		state_actor.selected_state = BaseActor.STATES.JUMPING
