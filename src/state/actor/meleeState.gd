class_name MeleeState
extends ActorState

@export var animation_name := "attack"

func enter_state():
	state_actor.stateLabel.text = "melee"

	state_actor.anim.connect("animation_finished", on_animation_finished)

	if !state_actor.anim.has_animation(animation_name):

		state_actor.selected_state = BaseActor.STATES.IDLE 

	else:
		state_actor.anim.play(animation_name)

func exit_state():
	state_actor.anim.disconnect("animation_finished", on_animation_finished) 

func on_animation_finished(_anim_name: String) -> void:

	if _anim_name == animation_name:
		state_actor.go()
		state_actor.selected_state = BaseActor.STATES.IDLE

