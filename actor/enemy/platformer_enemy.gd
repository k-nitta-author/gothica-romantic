class_name PlatformerEnemy
extends BaseEnemy

var noticed_player_on_floor := true

func update():

	super()

	update_seek_right()

	# TODO: optimize this when you can. it doesn't need to be called each frame
	if player.has_gotten_up():
	
		if !noticed_player_on_floor:
			is_flipped = player.global_position.x < global_position.x
			
			go()
			noticed_player_on_floor = true

	else:
		noticed_player_on_floor = false

func update_seek_right() -> void:
	seek_right = !(player.global_position.x < global_position.x)
