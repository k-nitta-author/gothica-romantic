class_name CheckPoint
extends Node2D

@onready var area2d : Area2D = $Area2D
@onready var sprite : Sprite2D = $Sprite2D
@onready var soundSfxStream : AudioStreamPlayer2D = $soundSfxStream
@onready var anim : AnimationPlayer = $anim

signal player_activated_checkpoint

func _ready() -> void:

    area2d.connect("area_entered", on_area_entered)

func on_area_entered(_area: Area2D) -> void:
    emit_signal("player_activated_checkpoint")