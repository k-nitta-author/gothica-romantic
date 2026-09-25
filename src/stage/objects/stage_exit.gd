class_name StageExit
extends Area2D

@export var NextLevel : PackedScene  
@export var egress_idx: int

signal player_exited(nextLevel, exit_type, _egress)

func bind_to_stage(stage: Stage) -> void:

    connect("player_exited", stage.end)

func _ready() -> void: connect("body_entered", on_body_entered)

# in the case of the base_stage exit, immediately change stage
func on_body_entered(body: Node2D) -> void: notify_stage_change()

# the stage change method
func notify_stage_change() -> void: emit_signal("player_exited", NextLevel, Stage.EXIT_TYPE.TO_NEXT_STAGE, egress_idx)