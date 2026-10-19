extends BaseManager

# calls bind deps on all basenpcs
func bind_dependencies(_stage: Stage):
	if _stage.game == null: return

	for c: BaseStageUtil in get_children(): c.bind_dependencies(_stage.game)