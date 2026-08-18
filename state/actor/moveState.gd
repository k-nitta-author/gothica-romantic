class_name MoveState
extends ActorState

func enter_state():
    print("move")
    state_actor.velocity.y = 0
    state_actor.velocity.x = 0

func exit_state(args: Dictionary= {}):

    if args.get("idle", null) == true:
        state_actor.selected_state = BaseActor.STATES.IDLE

    if args.get("jump", null) == true:
        state_actor.velocity.y -= state_actor.jump_force
        state_actor.selected_state = BaseActor.STATES.JUMPING

func update():
    
    state_actor.velocity.x = Input.get_axis("move_left", "move_right") * state_actor.speed
    state_actor.velocity.y += state_actor.speed_in_air_vertical

    if state_actor.velocity.x == 0: exit_state({"idle": true})

    if state_actor.is_on_floor():
        state_actor.anim.play("walk")

func handle_input(event: InputEvent):
    if event.is_action_pressed("jump"):
        exit_state({"jump": true})

    if event.is_action_pressed("duck"):
        state_actor.is_ducking = true
        exit_state({"idle": true})