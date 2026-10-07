class_name FlyingChargeState
extends MeleeState

func enter_state():
	state_actor.stateLabel.text = "flying charge"

func update():
	state_actor.attack()
