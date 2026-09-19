@tool
class_name PlatformerEnemy
extends BaseEnemy

enum MOVEMENT_MODE {CHASE_PLAYER, PATROL}

@export var currentMovementMode : MOVEMENT_MODE

var noticed_player_on_floor := true

# override bump method
func bump(body: Node2D) -> void: pass

func update():
	super()
	match currentMovementMode:
		MOVEMENT_MODE.CHASE_PLAYER:
			if player.has_gotten_up():
				if !noticed_player_on_floor:
					update_seek_right()			
					go()
					noticed_player_on_floor = true
			else:
				noticed_player_on_floor = false

		MOVEMENT_MODE.PATROL:
			if is_on_wall():
				seek_right = !seek_right

			if !onGroundRayLeft.is_colliding():
				
				seek_right = true
			elif !onGroundRayRight.is_colliding():
				seek_right = false


func update_seek_right() -> void:
	seek_right = !(player.global_position.x < global_position.x)
