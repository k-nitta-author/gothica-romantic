@tool
class_name PlatformerEnemy
extends BaseEnemy

var noticed_player_on_floor := true

# override bump method
func bump(body: Node2D) -> void: pass

func update():
	super()

	if player.has_gotten_up():
		if !noticed_player_on_floor:
			update_seek_right()			
			go()
			noticed_player_on_floor = true

	else:
		noticed_player_on_floor = false

func update_seek_right() -> void:
	seek_right = !(player.global_position.x < global_position.x)
