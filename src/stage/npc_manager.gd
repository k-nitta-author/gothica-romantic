class_name NPCManager
extends BaseManager

func bind_dependencies(_stage: Stage):

	if _stage.game == null: return

	for c in get_children():
		c.bind_dependencies(_stage.game.hudLayer)
