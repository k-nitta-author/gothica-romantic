class_name ShootState
extends ActorState

@export var animation_name := "attack"
@export var stops_actor : bool

func enter_state():
    state_actor.stateLabel.text = "shoot"

    if !state_actor.anim.has_animation(animation_name): state_actor.selected_state = BaseActor.STATES.IDLE 

    state_actor.anim.play(animation_name)

    if stops_actor: 
        state_actor.velocity.x = 0

func handle_input():
    if Input.is_action_pressed("shoot"):
        state_actor.anim.play("shoot")

        if state_actor.is_ducking:
            state_actor.anim.play("duck shoot")

    await state_actor.anim.animation_finished

    state_actor.selected_state = BaseActor.STATES.IDLE