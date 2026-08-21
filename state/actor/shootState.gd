class_name ShootState
extends ActorState

func handle_input():
    if Input.is_action_pressed("shoot"):
        state_actor.anim.play("shoot")

        if state_actor.is_ducking:
            state_actor.anim.play("duck shoot")

    await state_actor.anim.animation_finished

    state_actor.selected_state = BaseActor.STATES.IDLE