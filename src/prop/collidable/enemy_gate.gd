extends "res://src/prop/collidable/prop_collidable.gd"

@export var is_open : bool : set = set_is_open 
@export var tracked_enemy_group_name: String

@onready var tracked_enemy_group := get_tree().get_nodes_in_group(tracked_enemy_group_name)

func _ready() -> void:
    for enemy in tracked_enemy_group:
        var e : BaseActor = enemy
        e.connect("has_died", on_enemy_died)

# if an enemy in tracked_enemy_group has died
func on_enemy_died(enemy: BaseActor) -> void:

    if tracked_enemy_group.is_empty():
        is_open = true

    else:
        var idx = tracked_enemy_group.find(enemy)
        tracked_enemy_group.remove_at(idx)

# setter for the is_open variable
# plays animation whenever changed
# plays animation in reverse if false
func set_is_open(value: bool) -> void:
    is_open = value
    anim.play("open", -1, 1.0 if value else -1.0, value)
