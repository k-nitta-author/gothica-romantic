@tool
class_name PlatformerEnemy
extends BaseEnemy

enum MOVEMENT_MODE {CHASE_PLAYER, PATROL, ATTACKING}

@export var currentMovementMode : MOVEMENT_MODE

var noticed_player_on_floor := true

func stop_if_reach_slope(delta) -> void:
	if test_move(transform, direction * speed * delta):
		stop()
		
	elif selected_state == STATES.MOVING:
		go()

func turn_to_face_player(player_on_same_level: bool) -> void:
	if player.has_gotten_up() and player_on_same_level and self.can_move():
		update_seek_right()
		selected_state = STATES.MOVING					
		
func update(delta):

	
	super(delta)
	match currentMovementMode:
		MOVEMENT_MODE.CHASE_PLAYER:
			stop_if_reach_slope(delta)

			var player_on_same_level : bool = abs(player.global_position.y - global_position.y) < 2 and player.is_on_floor()

			if !onGroundRayRight.is_colliding() or !onGroundRayLeft.is_colliding():
				if !player_on_same_level:
					stop()
				else: 
					go()

			turn_to_face_player(player_on_same_level)

		MOVEMENT_MODE.PATROL:
			if is_on_wall():
				seek_right = !seek_right

			if !onGroundRayLeft.is_colliding():
				seek_right = true
			elif !onGroundRayRight.is_colliding():
				seek_right = false

		MOVEMENT_MODE.ATTACKING:
			pass

func update_seek_right() -> void:
	seek_right = !(player.global_position.x < global_position.x)
