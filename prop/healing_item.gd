extends CollectibleProp

@export var heal_amount: int

func OnAreaEntered(area: Area2D) -> void:
    hitPoints -= 1
    if area.owner is Player:
        var p: Player = area.owner
        p.heal(heal_amount)