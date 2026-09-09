class_name ActionDisappear
extends ActionOnCollide

func act_on(b: BaseBullet) -> void:
	b.isInactive = true
	var collision_point := b.global_position
	b.emit_signal("notify_attack_connection", collision_point, b.velocity.y < 0, Stage.SPLATTER.SHOOT)