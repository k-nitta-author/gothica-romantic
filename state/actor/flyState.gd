class_name FlyState
extends MoveState

func enter_state():
	print("fly")

func exit_state(args: Dictionary= {}):
	pass

func update():

	state_actor.fly()
