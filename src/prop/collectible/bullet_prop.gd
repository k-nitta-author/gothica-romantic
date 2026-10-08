extends CollectibleProp

func OnAreaEntered(area: Area2D) -> void:
	if area.owner is Player:
		var p: Player = area.owner
		p.gunManager.bulletsCurrent += 1
		collect()