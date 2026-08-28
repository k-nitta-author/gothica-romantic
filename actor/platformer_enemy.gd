@tool
class_name PlatformerEnemy
extends BaseEnemy


func update():
	# TODO: optimize this when you can. it doesn't need to be called each frame
	if player.is_on_floor():
		is_flipped = player.global_position.x < global_position.x
		update_seek_right()

	super()



func update_seek_right() -> void:
	seek_right = !(player.global_position.x < global_position.x)
