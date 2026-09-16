class_name JumpState
extends ActorState

@export var animantion_name:= "jump"

var has_taken_off : bool

# override method
func enter_state():
    state_actor.velocity.y = -state_actor.jump_force

    state_actor.stateLabel.text = "jump"

    has_taken_off = false
    state_actor.anim.play(animantion_name)

# override method
func exit_state() -> void:
    state_actor.cease_attack()

# override method; reserved for player
func handle_input():
    if state_actor.is_attacking: return

    if Input.is_action_pressed("attack"):
        state_actor.anim.play("jump attack")
        state_actor.attack()

    if Input.is_action_pressed("shoot"):
        state_actor.anim.play("jump shoot")

    state_actor.velocity.x = Input.get_axis("move_left", "move_right") * state_actor.speed_in_air_horizontal

# override method
func update():
    state_actor.velocity.y += state_actor.speed_in_air_vertical

    if !state_actor.is_on_floor():
        has_taken_off = true

        if has_taken_off: state_actor.selected_state = BaseActor.STATES.FALLLING
