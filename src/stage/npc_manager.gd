class_name NPCManager
extends BaseManager

func bind_dependencies(_stage: Stage):

	if stage.game == null: return

	for c in get_children():
		c.bind_dependencies(stage.game.hudLayer)
