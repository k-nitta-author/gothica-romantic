class_name JumpState
extends ActorState

var has_taken_off : bool

func enter_state():
    state_actor.velocity.y = -state_actor.jump_force

    state_actor.stateLabel.text = "jump"

    has_taken_off = false
    state_actor.anim.play("jump")

func handle_input():

    if Input.is_action_pressed("attack"):
        state_actor.anim.play("jump attack")


    if Input.is_action_pressed("shoot"):
        state_actor.anim.play("jump shoot")

    state_actor.velocity.x = Input.get_axis("move_left", "move_right") * state_actor.speed_in_air_horizontal


func update():
    state_actor.velocity.y += state_actor.speed_in_air_vertical

    if state_actor.velocity.y >= 64:
        exit_state()

    if !state_actor.is_on_floor():
        has_taken_off = true

    if state_actor.is_on_floor() and has_taken_off:
        exit_state() 
		



func exit_state(_args: Dictionary = {}):

    
    state_actor.selected_state = BaseActor.STATES.FALLLING

