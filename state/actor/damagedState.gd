class_name DamagedState
extends ActorState

func enter_state():
    state_actor.stateLabel.text = "damaged"

func update():
    state_actor.anim.play("damaged")
