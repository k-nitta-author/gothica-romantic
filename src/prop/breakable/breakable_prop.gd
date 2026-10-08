class_name BreakableProp
extends BaseProp

# the item that gets dropped on destruction
@export var item_drop : PackedScene

func destroy() -> void:
	if item_drop != null:
		emit_signal("destroyed", self, item_drop.instantiate())

func OnAreaEntered(area: Area2D) -> void:
	if area.owner is Player:
		hitPoints -= 1

	if area is BaseBullet:
		hitPoints -= 1
