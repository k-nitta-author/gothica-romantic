class_name WalkState
extends MoveState

func enter_state():

    state_actor.stateLabel.text = "walk"

    state_actor.velocity.y = 0
    state_actor.velocity.x = 0

func exit_state(args: Dictionary= {}):

    if args.get("idle", null) == true:
        state_actor.selected_state = BaseActor.STATES.IDLE

    if args.get("jump", null) == true:
        state_actor.velocity.y -= state_actor.jump_force
        state_actor.selected_state = BaseActor.STATES.JUMPING

    if args.get("fall", null) == true:
        state_actor.selected_state = BaseActor.STATES.FALLLING


func update():
    state_actor.walk()

    state_actor.velocity.y += state_actor.speed_in_air_vertical

    if state_actor.velocity.x == 0: exit_state({"idle": true})

    if !state_actor.is_on_floor():
        exit_state({"fall": true})

func handle_input():

    state_actor.walk()

    if Input.is_action_pressed("jump"):
        exit_state({"jump": true})

    if Input.is_action_pressed("duck"):
        state_actor.is_ducking = true
        exit_state({"idle": true})