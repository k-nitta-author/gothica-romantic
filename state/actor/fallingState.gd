class_name FallingState
extends ActorState


func enter_state():
    print("falling")

func exit_state(_args: Dictionary = {}):

    state_actor.selected_state = state_actor.STATES.LANDING

func update():
    if !state_actor.is_on_floor():
        state_actor.anim.queue("falling")
        state_actor.velocity.y += state_actor.speed_in_air_vertical * 8

    else:
        exit_state()