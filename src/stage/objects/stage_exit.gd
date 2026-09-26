class_name StageExit
extends Area2D

@export var is_usable: bool = true

@export var NextLevel : PackedScene
@export var egress_idx: int

signal player_exited(nextLevel, exit_type, _egress)

func toggle_is_usable() -> bool:
    
    is_usable = !is_usable

    return is_usable 

func bind_to_stage(stage: Stage) -> void:

    connect("player_exited", stage.end)

func _ready() -> void: connect("body_entered", on_body_entered)

# in the case of the base_stage exit, immediately change stage
func on_body_entered(body: Node2D) -> void: notify_stage_change()

# the stage change method
func notify_stage_change() -> void:

    if !is_usable: return 

    emit_signal("player_exited", NextLevel, Stage.EXIT_TYPE.TO_NEXT_STAGE, egress_idx)


func get_spawn_point() -> Vector2: return global_position