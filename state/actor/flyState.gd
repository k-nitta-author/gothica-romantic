class_name FlyState
extends MoveState

func enter_state():

	state_actor.stateLabel.text = "flying"

func exit_state(args: Dictionary= {}):
	pass

func update():

	state_actor.fly()
