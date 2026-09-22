class_name WalkState
extends MoveState

func enter_state():
	state_actor.anim.play("walk")
	state_actor.stateLabel.text = "walk"

	state_actor.is_shooting = false
	state_actor.is_attacking = false

	state_actor.go()

func update():

	state_actor.walk()

	state_actor.velocity.y += state_actor.speed_in_air_vertical

	if !state_actor.is_on_floor(): state_actor.selected_state = BaseActor.STATES.FALLLING

func handle_input():

	if Input.is_action_pressed("attack"):
		state_actor.attack()
		state_actor.selected_state = BaseActor.STATES.MELEE
		state_actor.stop()
		return

	var has_horizontal_input := Input.is_action_pressed("move_left", true) or Input.is_action_pressed("move_right", true)

	state_actor.walk()

	state_actor.anim.play("walk")

	if !has_horizontal_input:
		state_actor.selected_state = BaseActor.STATES.IDLE
		return

	if Input.is_action_pressed("jump"):
		state_actor.velocity.y -= state_actor.jump_force
		state_actor.selected_state = BaseActor.STATES.JUMPING

	if Input.is_action_pressed("duck"):
		state_actor.is_ducking = true
		state_actor.selected_state = BaseActor.STATES.IDLE
