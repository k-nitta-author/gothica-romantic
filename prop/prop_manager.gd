extends Node2D

@onready var props := get_children()

func _physics_process(delta: float) -> void:

    for p in props: p.update()