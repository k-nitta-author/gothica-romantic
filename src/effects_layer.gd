class_name EffectsLayer
extends CanvasLayer

@onready var transitionSurface : ColorRect = $transitionSurface
@onready var anim : AnimationPlayer = $anim

signal transition_finished

# the different trans types
enum TRANS {
    WIPE_LEFT,
    WIPE_RIGHT,
    WIPE_UP,
    WIPE_DOWN,
    IRIS_OUT,
    IRIS_IN
}

func _ready() -> void:
    anim.connect("animation_finished", _on_anim_finished)

func _on_anim_finished(_anim_name: String) -> void:
    emit_signal("transition_finished")

# plays the transition for the effects layer
func play_transition(trans_type: TRANS, reverse: bool = false) -> void: 

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
    anim.play(anim_dict[trans_type], -1, 1.0 if !reverse else -1.0, reverse)