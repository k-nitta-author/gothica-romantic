class_name ActionOnCollide
extends Resource


# sets up the bullet to perform the collision
func setup(b: BaseBullet, s: Stage) -> void: pass

# meant to be overriden by child classes
func act_on(b: BaseBullet, area: Area2D) -> void:
    var collision_point := b.global_position
    b.emit_signal("notify_attack_connection", collision_point, b.velocity.y < 0, Stage.SPLATTER.SHOOT)
    b.isInactive = true

func act_on_body(b: BaseBullet, body: Node2D) -> void:
    var collision_point := b.global_position
    b.emit_signal("notify_attack_connection", collision_point, b.velocity.y < 0, Stage.SPLATTER.SHOOT)
    b.isInactive = true
