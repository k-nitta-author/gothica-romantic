class_name MeleeState
extends ActorState

func enter_state():
    state_actor.stateLabel.text = "melee"
    state_actor.anim.play("attack")
    state_actor.velocity.x = 0


func handle_input():
    if Input.is_action_pressed("attack"):
        state_actor.anim.play("attack" if state_actor.is_ducking else "duck attack")
            
    state_actor.selected_state = BaseActor.STATES.IDLE 

func update():
    pass

