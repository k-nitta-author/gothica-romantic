class_name ExitManager
extends BaseManager

func bind_dependencies(stage: Stage):
    for c in get_children():

        c.connect("player_exited", stage.end)