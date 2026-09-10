class_name LandingState
extends ActorState

func enter_state():
	state_actor.stateLabel.text = "land"
	state_actor.anim.connect("animation_finished", on_animation_finished, ConnectFlags.CONNECT_ONE_SHOT)

func exit_state():
	state_actor.anim.disconnect("animation_finished", on_animation_finished)

func on_animation_finished(anim_name: String) -> void:
	if anim_name == "land": state_actor.selected_state = BaseActor.STATES.IDLE

func update():
	state_actor.anim.play("land")
