extends Node2D

enum SPLATTER {SHOOT, SLASH}

@onready var shoot_splatter = preload("uid://bjjv01r2sxehu")
@onready var slash_splatter = preload("uid://dam2cxs8um8t1")
	
# spawn a given effect at this location
func spawn_effects(pos: Vector2, is_flipped: int, splatter_type: SPLATTER) -> void:

	var splatter

	match splatter_type:
		SPLATTER.SLASH: splatter = slash_splatter.instantiate()
		SPLATTER.SHOOT: splatter = shoot_splatter.instantiate()

	splatter.global_position = pos

	if !is_flipped: splatter.scale.x  *= -1

	add_child(splatter)