class_name DamagedState
extends ActorState

func enter_state():
    state_actor.stateLabel.text = "damaged"

    if state_actor.immune_to_stun and state_actor is BaseEnemy:
        state_actor.sprite.is_hit_flashing = true
        state_actor.revert_to_previous_state()
        
    else:
        # TODO: fix this when you can 
        if state_actor.anim.has_animation("damaged"):
            state_actor.anim.stop()
            state_actor.anim.call_deferred("play", "damaged")

func update():
    state_actor.velocity.y += state_actor.speed_in_air_vertical
    
