class_name IdleState
extends ActorState

func enter_state():
    state_actor.anim.play("RESET")
    state_actor.velocity.x = 0
    print("idle")

func exit_state(args: Dictionary = {}):

    if args.get("jump", null) == true:
        state_actor.selected_state = BaseActor.STATES.JUMPING
    if args.get("move", null) == true:
        state_actor.selected_state = BaseActor.STATES.MOVING
    if args.get("duck", null) == true:
        state_actor.selected_state = BaseActor.STATES.DUCKING

func update():

    state_actor.velocity.y += state_actor.speed_in_air_vertical

    if Input.is_action_pressed("duck"):
        state_actor.is_ducking = true
        state_actor.anim.play("duck")
        exit_state({"duck": true})

    elif Input.is_action_pressed("attack"):
        state_actor.anim.play("attack")

    elif Input.is_action_pressed("shoot"):
        state_actor.anim.play("shoot")

    if Input.get_axis("move_left", "move_right"):
        exit_state({"move": true})

func handle_input(event: InputEvent):

    if event.is_action_pressed("jump"):
        exit_state({"jump": true})