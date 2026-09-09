class_name ActionSpawnOnCollide
extends ActionOnCollide

func act_on(b: BaseBullet) -> void:

    b.isInactive = true