class_name IdleState
extends ActorState

func enter_state():
	state_actor.stateLabel.text = "idle"

	state_actor.idle()

	if state_actor.anim.has_animation("idle"): state_actor.anim.play("idle")

func on_animation_finished(animantion_name: String):
	pass

func exit_state() -> void:

	state_actor.cease_attack()

func update():

	state_actor.velocity.y += state_actor.speed_in_air_vertical

	if abs(state_actor.velocity.x) > 0:
		state_actor.selected_state = BaseActor.STATES.MOVING

func handle_input():

	if Input.is_action_pressed("duck") and !state_actor.is_attacking:
		state_actor.is_ducking = true
		state_actor.anim.play("duck")
		state_actor.selected_state = BaseActor.STATES.DUCKING

	elif Input.is_action_just_pressed("attack"):
		state_actor.attack()
		state_actor.anim.play("attack")

	elif Input.is_action_pressed("shoot"):
		state_actor.anim.play("shoot")

	var has_horizontal_input := Input.is_action_pressed("move_left", true) or Input.is_action_pressed("move_right", true)  

	if has_horizontal_input and !state_actor.is_attacking:
		state_actor.selected_state = BaseActor.STATES.MOVING
		return

	if Input.is_action_pressed("jump") and state_actor.is_on_floor() and !state_actor.is_attacking:
		state_actor.selected_state = BaseActor.STATES.JUMPING
