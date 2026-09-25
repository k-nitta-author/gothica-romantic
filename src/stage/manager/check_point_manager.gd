extends Node2D

func get_checkpoint_by_idx(idx: int) -> CheckPoint:
    return get_children()[idx] 

func bind_dependencies(stage: Stage, game: Game) -> void:
    for i in range(get_children().size()):
        var child: CheckPoint = get_children()[i]
        child.idx = i
        child.bind_to_stage(stage)
