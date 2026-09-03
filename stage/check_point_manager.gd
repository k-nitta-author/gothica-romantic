extends Node2D

@onready var children = self.get_children()

func bind_dependencies(stage: Stage, game: Game) -> void:
    for i in range(children.size()):

        var child = children[i]

        if child is CheckPoint:
            child.idx = i
            child.connect(
            "player_activated_checkpoint",
            stage.on_player_checkpoint_activated
        )

