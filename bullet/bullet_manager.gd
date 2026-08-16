extends Node2D

@onready var children := get_children()

func _physics_process(_delta: float) -> void:
    for c in children: c.update() # call update on each bullet 