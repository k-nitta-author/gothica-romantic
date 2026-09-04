class_name MeleeState
extends ActorState

@export var animation_name := "attack"
@export var stops_actor : bool

func enter_state():
    state_actor.stateLabel.text = "melee"

    if !state_actor.anim.has_animation(animation_name): state_actor.selected_state = BaseActor.STATES.IDLE 

    state_actor.anim.play(animation_name)

    if stops_actor: 
        state_actor.velocity.x = 0


func handle_input():
    if Input.is_action_pressed("attack"):
        state_actor.anim.play("attack" if state_actor.is_ducking else "duck attack")
            
    state_actor.selected_state = BaseActor.STATES.IDLE 

func update():
    pass

