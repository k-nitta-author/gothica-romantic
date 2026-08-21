class_name DuckingState
extends ActorState

func enter_state():
    state_actor.velocity.y = 0
    state_actor.velocity.x = 0

func exit_state(_args: Dictionary = {}):

    state_actor.selected_state = BaseActor.STATES.IDLE

func handle_input():
    if Input.is_action_just_released("duck"): 
        exit_state()

    if Input.is_action_pressed("attack"):
        state_actor.anim.play("duck attack")

    if Input.is_action_pressed("shoot"):
        state_actor.anim.play("duck shoot")
