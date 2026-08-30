extends Node2D

@onready var children = self.get_children()

func bind_dependencies(stage: Stage) -> void:
    for c in children:
        if c is CheckPoint: c.connect(
            "player_activated_checkpoint",
            stage.on_player_checkpoint_activated
        )

