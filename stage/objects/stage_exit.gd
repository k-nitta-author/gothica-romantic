extends Area2D

@export var NextLevel : PackedScene  

signal player_exited(nextLevel)

func _ready() -> void:
	connect("body_entered", on_body_entered)

func on_body_entered(body: Node2D) -> void:
	if body is Player:
		emit_signal("player_exited", NextLevel)