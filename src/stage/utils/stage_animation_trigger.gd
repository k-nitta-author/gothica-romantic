extends BaseStageUtil

@export var animattion_name := ""

@onready var stage := get_parent()

func trigger_animation() -> void:
    if !stage is Stage: return
    
    stage.anim.play(animattion_name)