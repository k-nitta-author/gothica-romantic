class_name CheckPoint
extends Node2D

@onready var area2d : Area2D = $Area2D
@onready var sprite : Sprite2D = $Sprite2D
@onready var soundSfxStream : AudioStreamPlayer2D = $soundSfxStream
@onready var anim : AnimationPlayer = $anim

var idx : int

signal player_activated_checkpoint

# connect area entered with proper handler
func _ready() -> void:
    area2d.connect("area_entered", on_area_entered)

# handles player entering checkpoint area
func on_area_entered(_area: Area2D) -> void:
    area2d.call_deferred("set", "monitoring", false)
    emit_signal("player_activated_checkpoint", idx)

# bind to the stage
func bind_to_stage(stage: Stage) -> void:
    connect("player_activated_checkpoint", stage.on_player_checkpoint_activated)