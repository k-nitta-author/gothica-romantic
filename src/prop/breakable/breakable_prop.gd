class_name BreakableProp
extends BaseProp

# the item that gets dropped on destruction
@export var current_item_drop := PropManager.DROPS.NONE

signal spawn_collectible(dropped_item: PropManager.DROPS)

func bind_dependencies(_stage: Stage) -> void:
	connect("spawn_collectible", _stage.propManager.spawn_collectible)

func destroy() -> void:
	if current_item_drop != PropManager.DROPS.NONE:
		emit_signal("spawn_collectible", self, current_item_drop)

func OnAreaEntered(area: Area2D) -> void:
	if area.owner is Player:
		hitPoints -= 1

	if area is BaseBullet:
		hitPoints -= 1
