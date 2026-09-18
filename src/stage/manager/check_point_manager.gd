extends Node2D

func bind_dependencies(stage: Stage, game: Game) -> void:
    for i in range(get_children().size()):
        var child: CheckPoint = get_children()[i]
        child.idx = i
        child.connect(
            "player_activated_checkpoint",
            stage.on_player_checkpoint_activated
            )

