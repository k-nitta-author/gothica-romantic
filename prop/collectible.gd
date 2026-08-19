class_name CollectibleProp
extends BaseProp

signal collected(collectible: CollectibleProp)

func OnAreaEntered(area: Area2D) -> void:
	super(area)

	hitPoints -= 1
	emit_signal("collected", self)
