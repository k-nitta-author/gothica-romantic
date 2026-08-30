extends Node2D

@onready var children := get_children()
@onready var player := $Player
@onready var bosses : Array

func bind_dependencies(stage: Stage) -> void:
    for c in get_children():
        c.bind_dependencies(stage)
        c.connect("has_died", stage.spawn_collectible)
        c.connect("attacked_at_point", stage.spawn_effects)

        if c is BaseEnemy and c.is_boss: bosses.append(c)

func get_bosses() -> Array: return bosses

func _physics_process(_delta: float) -> void:
    
    for c in children:
        c.update()

func _unhandled_input(event: InputEvent) -> void:
    player.use_input(event)