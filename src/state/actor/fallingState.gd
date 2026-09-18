class_name FallingState
extends ActorState

@export var fall_speed_multiplier : int

var fall_height: float

func exit_state():
    pass

func enter_state():
    state_actor.stateLabel.text = "falling"
    fall_height = state_actor.global_position.y

func handle_input():

    if state_actor.is_attacking: return

    if Input.is_action_pressed("attack"):
        state_actor.attack()
        state_actor.anim.play("jump attack")

    if Input.is_action_pressed("shoot"):
        state_actor.anim.play("jump shoot")

func update():

    state_actor.fall(fall_height)

    if !state_actor.is_on_floor():
        state_actor.anim.queue("falling")
        state_actor.velocity.y += state_actor.speed_in_air_vertical * fall_speed_multiplier
        state_actor.velocity.x = Input.get_axis("move_left", "move_right") * state_actor.speed_in_air_horizontal 

    else:
        

        if state_actor.landing_state != null:
            state_actor.selected_state = state_actor.STATES.LANDING

        else:
            state_actor.selected_state = state_actor.STATES.IDLE