class_name FlyState
extends MoveState

func enter_state():

	state_actor.stateLabel.text = "flying"
	state_actor.anim.play("fly")

	state_actor.is_shooting = false
	state_actor.is_attacking = false

	state_actor.go()

func update():

	state_actor.fly()
