extends Node2D

@onready var children := get_children()
@onready var player := $Player

func bind_dependencies(stage: Stage) -> void:
    for c in get_children():
        c.bind_dependencies(stage)
        c.connect("has_died", stage.spawn_collectible)
        

func _physics_process(_delta: float) -> void:
    
    for c in children:
        c.update()

func _unhandled_input(event: InputEvent) -> void:
    player.use_input(event)