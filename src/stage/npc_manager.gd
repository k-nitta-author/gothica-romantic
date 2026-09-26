class_name NPCManager
extends BaseManager

func bind_dependencies(stage: Stage):
	for c in get_children():
		c.bind_dependencies(stage.game.hudLayer)
