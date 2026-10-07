class_name FlyingChargeState
extends MeleeState

func enter_state():
    state_actor.stateLabel.text = "flying charge"
    state_actor.anim.connect("animation_finished", on_animation_finished)


func update():
    state_actor.attack()
