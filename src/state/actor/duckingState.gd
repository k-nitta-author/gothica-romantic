class_name DuckingState
extends ActorState

func enter_state():
    state_actor.velocity.y = 0
    state_actor.velocity.x = 0

func exit_state() -> void:
    state_actor.cease_attack()

func handle_input():
    if Input.is_action_just_released("duck"):
        state_actor.anim.play("walk")
        state_actor.selected_state = BaseActor.STATES.IDLE

    if Input.is_action_pressed("attack"):
        state_actor.attack()
        state_actor.anim.play("duck attack")

    if Input.is_action_pressed("shoot"):
        state_actor.anim.play("duck shoot")
