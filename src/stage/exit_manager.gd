class_name ExitManager
extends BaseManager

@onready var children := get_children()

func get_stage_door_by_idx(door_idx: int) -> StageExit:
	return children[door_idx]

# load deps into this and child classes
func bind_dependencies(stage: Stage):
	super(stage)
	for c in children:
		c.bind_to_stage(stage)

# called whenever the player body touches any stageExit
# alerts the stage that it is time to pack up and go
func on_player_exit_stage():
	pass
