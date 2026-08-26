extends CollectibleProp



func OnAreaEntered(area: Area2D) -> void:
	hitPoints -= 1
	if area.owner is Player:
		var p: Player = area.owner
		p.bulletsCurrent += 1
		collect()