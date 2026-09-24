@tool
class_name PlatformerEnemy
extends BaseEnemy

enum MOVEMENT_MODE {CHASE_PLAYER, PATROL}

@export var currentMovementMode : MOVEMENT_MODE

var noticed_player_on_floor := true

func update():
	super()
	match currentMovementMode:
		MOVEMENT_MODE.CHASE_PLAYER:
			var player_on_same_level : bool = abs(player.global_position.y - global_position.y) < 4 and player.is_on_floor()


			if !onGroundRayLeft.is_colliding():
				if !player_on_same_level:
					stop()
				else: 
					go()
			if !onGroundRayRight.is_colliding():
				if !player_on_same_level:
					stop()
				else: 
					go()

			if player.has_gotten_up() and player_on_same_level:
				if !noticed_player_on_floor:
					update_seek_right()
					noticed_player_on_floor = true
					selected_state = STATES.MOVING



			else:
				noticed_player_on_floor = false

			if player_on_same_level:
				update_seek_right()
				return

		MOVEMENT_MODE.PATROL:
			if is_on_wall():
				seek_right = !seek_right

			if !onGroundRayLeft.is_colliding():
				seek_right = true
			elif !onGroundRayRight.is_colliding():
				seek_right = false

func update_seek_right() -> void:
	seek_right = !(player.global_position.x < global_position.x)
