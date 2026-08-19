extends BaseProp

func OnAreaEntered(area: Area2D) -> void:
	
	if area.owner is Player:
		hitPoints -= 1

	if area is BaseBullet:
		hitPoints -= 1
