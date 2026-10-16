class_name EffectsManager
extends Node2D

enum EFFECT {SHOOT, SLASH, BURST_1, BURST_2, BASE_EXPLOSION}

@onready var shoot_splatter = preload("uid://bjjv01r2sxehu")
@onready var slash_splatter = preload("uid://dam2cxs8um8t1")

@onready var burst_flame_1 = preload("uid://cydfoii50pto8")
@onready var burst_flame_2 = preload("uid://4y0q6cwaf2vx")

@onready var base_explosion = preload("res://src/base_explosion.tscn")

func get_effect(splatter_type: EFFECT) -> Node:
	var splatter = null
	
	match splatter_type:
		EFFECT.SLASH: splatter = slash_splatter
		EFFECT.SHOOT: splatter = shoot_splatter
		EFFECT.BURST_1: splatter = burst_flame_1
		EFFECT.BURST_2: splatter = burst_flame_2
		EFFECT.BASE_EXPLOSION: splatter = base_explosion

	return splatter.instantiate()
	
# spawn a given effect at this location
func spawn_effects(pos: Vector2, is_flipped: int, splatter_type: EFFECT) -> void:

	var s = get_effect(splatter_type)
	s.global_position = pos
	if !is_flipped: s.scale.x  *= -1

	call_deferred("add_child", s)