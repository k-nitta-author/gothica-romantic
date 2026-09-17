class_name DuckingState
extends ActorState

func enter_state():
    state_actor.stateLabel.text = "duck"
    state_actor.velocity.x = 0

func exit_state() -> void:
    state_actor.cease_attack()

func update():
    state_actor.velocity.y += state_actor.speed_in_air_vertical

    if !state_actor.is_on_floor(): state_actor.selected_state = BaseActor.STATES.FALLLING

func handle_input():
    
    if state_actor.is_attacking or state_actor.is_shooting: return

    else: state_actor.anim.play("duck")

    if Input.is_action_pressed("jump"): state_actor.jump_down()

    if Input.is_action_just_pressed("attack"):
        state_actor.attack()
        state_actor.anim.play("duck attack")

    elif Input.is_action_just_pressed("shoot"):
        state_actor.anim.play("duck shoot")
        state_actor.is_shooting = true

    if !Input.is_action_pressed("duck"):
        state_actor.anim.play("idle")
        state_actor.selected_state = BaseActor.STATES.IDLE


