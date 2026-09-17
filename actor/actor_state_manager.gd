extends Node


func match_state(state: BaseActor.STATES, actor: BaseActor) -> BaseState:
    match state:
        BaseActor.STATES.IDLE:  return actor.idle_state
        BaseActor.STATES.JUMPING: return actor.jump_state
        BaseActor.STATES.MOVING: return actor.move_state
        BaseActor.STATES.FALLLING: return actor.falling_state
        BaseActor.STATES.MELEE: return actor.melee_state
        BaseActor.STATES.SHOOT: return actor.shoot_state
        BaseActor.STATES.LANDING: return actor.landing_state
        BaseActor.STATES.DUCKING:return actor.ducking_state
        BaseActor.STATES.DAMAGED: return actor.damaged_state
        
    return null
