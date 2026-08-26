class_name CollectibleProp
extends BaseProp

signal collected(collectible: CollectibleProp)


func collect() -> void:
	emit_signal("collected", self)

func OnAreaEntered(area: Area2D) -> void:
	super(area)

	collect()
	hitPoints -= 1

