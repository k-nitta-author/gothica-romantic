class_name FlyState
extends MoveState

func enter_state():

	state_actor.stateLabel.text = "flying"

func update():

	state_actor.fly()
