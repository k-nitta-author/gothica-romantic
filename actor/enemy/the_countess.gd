extends PlatformerEnemy

enum SHOOT_MODE {BASIC, FROM_ABOVE}

@export var current_shoot_mode : SHOOT_MODE = SHOOT_MODE.BASIC

# override fire method
func fire() -> BaseBullet:
	var b: BaseBullet = shoot_bullet.instantiate()

	match current_shoot_mode:
		SHOOT_MODE.BASIC:
			b.movement_angle = 270 if is_flipped else 90
		SHOOT_MODE.FROM_ABOVE:
			b.movement_angle = 235 if is_flipped else 45

	emit_signal("fire_gun", b, firingPoint.global_position)

	return b