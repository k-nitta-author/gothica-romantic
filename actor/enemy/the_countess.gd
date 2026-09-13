extends PlatformerEnemy

enum SHOOT_MODE {BASIC, FROM_ABOVE}

@export var current_shoot_mode : SHOOT_MODE = SHOOT_MODE.BASIC

@export var watching_for_player_attack: bool # if true, watch out for player sword attack

# handle it; try to override current selected state when necessary
func update() -> void:

	if watching_for_player_attack:
		
		# do the high jump if player is too close
		if is_player_attacking_close(): pass

	super()

# if player's performs attack while too close
func is_player_attacking_close() -> bool: return player.is_attacking and abs(player.global_position.x - global_position.x) < melee_limit  

# override fire method
func fire() -> BaseBullet:
	var b: BaseBullet = shoot_bullet.instantiate()

	match current_shoot_mode:
		
		# when the countess shoots on level with the player
		SHOOT_MODE.BASIC: b.movement_angle = 270 if is_flipped else 90
		
		# when the countess shoots from above
		SHOOT_MODE.FROM_ABOVE: b.movement_angle = 225 if is_flipped else 135

	emit_signal("fire_gun", b, firingPoint.global_position)

	return b