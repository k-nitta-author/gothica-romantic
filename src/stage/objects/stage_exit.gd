class_name StageExit
extends Area2D

@export var NextLevel : PackedScene  

signal player_exited(nextLevel)

func bind_to_stage(stage: Stage) -> void: pass

func _ready() -> void: connect("body_entered", on_body_entered)

# in the case of the base_stage exit, immediately change stage
func on_body_entered(body: Node2D) -> void: notify_stage_change()

# the stage change method
func notify_stage_change() -> void: emit_signal("player_exited", NextLevel)