class_name EffectsManager
extends Node2D

enum SPLATTER {SHOOT, SLASH, BURST_1, BURST_2}

@onready var shoot_splatter = preload("uid://bjjv01r2sxehu")
@onready var slash_splatter = preload("uid://dam2cxs8um8t1")

@onready var burst_flame_1 = preload("uid://cydfoii50pto8")
@onready var burst_flame_2 = preload("uid://4y0q6cwaf2vx")

func get_effect(splatter_type: SPLATTER) -> Node:
	var splatter = null
	
	match splatter_type:
		SPLATTER.SLASH: splatter = slash_splatter.instantiate()
		SPLATTER.SHOOT: splatter = shoot_splatter.instantiate()
		SPLATTER.BURST_1: splatter = burst_flame_1.instantiate()
		SPLATTER.BURST_2: splatter = burst_flame_2.instantiate()

	return splatter
	
# spawn a given effect at this location
func spawn_effects(pos: Vector2, is_flipped: int, splatter_type: SPLATTER) -> void:

	var s = get_effect(splatter_type)
	s.global_position = pos
	if !is_flipped: s.scale.x  *= -1
	add_child(s)