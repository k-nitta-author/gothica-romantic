class_name NPCManager
extends BaseManager

func _ready() -> void:
	load_npc_status()

func get_all() -> Array: return get_children()

func hide_all() -> void:
	for npc: BaseNPC in get_all(): npc.visible = false

# based on the npc data
func load_npc_status() -> void:
	var data := {}

	for c: BaseNPC in get_all():
		c.setup_persistent_status(data)

func bind_dependencies(_stage: Stage):
	if _stage.game == null: return

	for c: BaseNPC in get_all(): c.bind_dependencies(_stage.game.hudLayer)
