extends Node2D

@onready var children := get_children()
@onready var player := $Player

func _physics_process(_delta: float) -> void:
    
    for c in children:
        pass