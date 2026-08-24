class_name FlyingChargeState
extends MeleeState

func enter_state() -> void:
    super()

func update():

    state_actor.attack()