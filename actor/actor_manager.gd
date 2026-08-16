extends Node2D

@onready var children := get_children()
@onready var player := $Player

func _physics_process(_delta: float) -> void:
    
    for c in children:
        c.update()

func _unhandled_input(event: InputEvent) -> void:
    player.use_input(event)