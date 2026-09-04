class_name BaseNPC
extends Node2D

@onready var interactionArea: Area2D
@onready var bodySprite: Sprite2D
@onready var anim: AnimationPlayer

var is_player_interactible: bool

func _ready() -> void:
    interactionArea.connect("area_entered", on_area_entered)
    interactionArea.connect("area_exited", on_area_exited)

func interact() -> void:
    pass

func on_area_exited(area: Area2D) -> void:
    is_player_interactible = false

func on_area_entered(area: Area2D) -> void:
    is_player_interactible = true