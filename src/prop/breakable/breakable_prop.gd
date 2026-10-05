class_name BreakableProp
extends BaseProp

# the item that gets dropped on destruction
@export var item_drop : PackedScene

func OnAreaEntered(area: Area2D) -> void:
	if area.owner is Player:
		hitPoints -= 1

	if area is BaseBullet:
		hitPoints -= 1
