class_name ActionOnCollide
extends Resource


# sets up the bullet to perform the collision
func setup(b: BaseBullet, s: Stage) -> void: pass

# meant to be overriden by child classes
func act_on(b: BaseBullet) -> void: pass