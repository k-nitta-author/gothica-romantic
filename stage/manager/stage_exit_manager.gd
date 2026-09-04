extends Node2D

@onready var children := get_children()

func _ready() -> void:

    for c in children: c.connect("player_exited", on_player_exit_stage)

# called whenever the player body touches any stageExit
# alerts the stage that it is time to pack up and go
func on_player_exit_stage():
    pass