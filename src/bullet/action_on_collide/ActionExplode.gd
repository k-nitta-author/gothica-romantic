class_name ActionExplode
extends ActionOnCollide

@export var explosion_duration : float

# override virtual to allow for explosion
func act_on(b: BaseBullet, area: Area2D) -> void:
    pass