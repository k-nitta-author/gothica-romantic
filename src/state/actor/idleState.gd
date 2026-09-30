class_name IdleState
extends ActorState

func enter_state():
	state_actor.stateLabel.text = "idle"

	state_actor.idle()

	if state_actor.anim.has_animation("idle"): state_actor.anim.play("idle")

func exit_state() -> void:
	state_actor.cease_attack()

func update():

	state_actor.idle()

	state_actor.velocity.y += state_actor.speed_in_air_vertical

	state_actor.move_if_possible()

func handle_input():
	var has_horizontal_input := Input.is_action_pressed("move_left", true) or Input.is_action_pressed("move_right", true)  

	if state_actor.is_attacking or state_actor.is_shooting or state_actor.is_drinking: return

	# consume potion and reduce based on how how much hp the player has
	if Input.is_action_pressed("drinkPotion") and state_actor.can_heal():
		state_actor.potionManager.current_potion_count -= 1
		state_actor.anim.play("drink")

	if Input.is_action_pressed("duck"):
		state_actor.is_ducking = true
		state_actor.anim.play("duck")
		state_actor.selected_state = BaseActor.STATES.DUCKING

	elif Input.is_action_just_pressed("attack"):
		state_actor.attack()
		state_actor.anim.play("attack")
		return

	elif Input.is_action_pressed("shoot"):
		state_actor.anim.play("shoot")

	if has_horizontal_input:
		state_actor.selected_state = BaseActor.STATES.MOVING
		return

	if Input.is_action_pressed("jump") and state_actor.is_on_floor():
		state_actor.selected_state = BaseActor.STATES.JUMPING
