class_name DamagedState
extends ActorState

func enter_state():
    state_actor.stateLabel.text = "damaged"

    # TODO: fix this when you can 
    if state_actor.anim.has_animation("damaged"):
        state_actor.anim.stop()
        state_actor.anim.call_deferred("play", "damaged")

func update():
    pass
    
