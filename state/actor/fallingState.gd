class_name FallingState
extends ActorState

@export var fall_speed_multiplier : int

func enter_state():
    print("falling")

func exit_state(_args: Dictionary = {}):

    state_actor.selected_state = state_actor.STATES.LANDING

func handle_input(event: InputEvent):

    print("asd")

    if event.is_action_pressed("attack"):
        state_actor.anim.play("jump attack")


    if event.is_action_pressed("shoot"):
        state_actor.anim.play("jump shoot")

func update():
    if !state_actor.is_on_floor():
        state_actor.anim.queue("falling")
        state_actor.velocity.y = state_actor.speed_in_air_vertical * fall_speed_multiplier
        state_actor.velocity.x = Input.get_axis("move_left", "move_right") * state_actor.speed_in_air_horizontal 

    else:
        exit_state()