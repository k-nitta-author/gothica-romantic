class_name DamagedState
extends ActorState

func enter_state():
    state_actor.stateLabel.text = "damaged"

    state_actor.cease_attack()
    state_actor.cease_shoot()

    if state_actor.immune_to_stun and state_actor is BaseEnemy:
        state_actor.sprite.is_hit_flashing = true
        state_actor.revert_to_previous_state()
        
    else:
        # TODO: fix this when you can 
        if state_actor.anim.has_animation("damaged"):
            state_actor.anim.stop()
            state_actor.anim.call_deferred("play", "damaged")

    state_actor.anim.connect("animation_finished", on_animation_finished)

func exit_state():
    state_actor.anim.disconnect("animation_finished", on_animation_finished)


func on_animation_finished(animation_name: String) -> void:
    state_actor.selected_state = BaseActor.STATES.IDLE

func update():
    state_actor.velocity.y += state_actor.speed_in_air_vertical
    
