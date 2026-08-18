class_name JumpState
extends ActorState


func enter_state():
    state_actor.velocity.y = -state_actor.jump_force

func update():
    state_actor.anim.play("jump")
    state_actor.velocity.y += state_actor.speed_in_air_vertical
    
    if state_actor.velocity.y >= 64:
        exit_state()
		
func exit_state(_args: Dictionary = {}):
    state_actor.selected_state = BaseActor.STATES.FALLLING
