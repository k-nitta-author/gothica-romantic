extends CanvasLayer

@onready var transitionSurface : ColorRect = $transitionSurface
@onready var anim : AnimationPlayer = $anim

# the different trans types
enum TRANS {
    WIPE_LEFT,
    WIPE_RIGHT,
    WIPE_UP,
    WIPE_DOWN,
    IRIS_OUT,
    IRIS_IN
}

# plays the transition for the effects layer
func play_transition(trans_type: TRANS) -> void: 

    # map chosen TRANS type with corresponding animation
    const anim_dict = {
        TRANS.WIPE_LEFT: "side_wipe_left",
        TRANS.WIPE_RIGHT: "side_wipe_right",
        TRANS.WIPE_UP: "side_wipe_up",
        TRANS.WIPE_DOWN: "side_wipe_down",
        TRANS.IRIS_IN: "iris_in",
        TRANS.IRIS_OUT: "iris_out"
        }

    # play animation itself
    anim.play(anim_dict[trans_type])