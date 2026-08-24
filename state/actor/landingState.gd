class_name LandingState
extends ActorState

func enter_state():

	state_actor.stateLabel.text = "land"


func exit_state(_args: Dictionary = {}):
	state_actor.selected_state = BaseActor.STATES.IDLE

func update():
	#state_actor.anim.play("landing")
	
	exit_state()
