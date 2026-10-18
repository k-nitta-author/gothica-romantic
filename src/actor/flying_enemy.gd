@tool
class_name FlyingEnemy
extends BaseEnemy

enum TARGET {EDGE_TOP, EDGE_BOTTOM, PLAYER}

@export var current_target := TARGET.EDGE_TOP

var target_edge : float

var target : Vector2

@export var charge_speed: float = 35
@export var fly_in_loop: bool
@export var fly_range: float

@onready var perch_position : Vector2 = self.global_position
@onready var fly_range_left_edge: float = perch_position.x - fly_range / 2
@onready var fly_range_right_edge: float = perch_position.x + fly_range / 2

var is_out_of_bounds: bool

func is_left_edge_nearest() -> bool:
	var distance_to_left : float = abs(fly_range_left_edge - global_position.x)
	var distance_to_right : float = abs(fly_range_right_edge - global_position.x)

	return distance_to_right > distance_to_left

func get_nearest_edge() -> float:
	return fly_range_left_edge if is_left_edge_nearest() else fly_range_right_edge

func get_furthest_edge() -> float:

	return fly_range_left_edge if !is_left_edge_nearest() else fly_range_right_edge

func update_seek_right() -> void:

		if !is_out_of_bounds: return

		if is_awake and current_target !=TARGET.PLAYER:
			current_target = TARGET.EDGE_BOTTOM
			target_edge = get_nearest_edge()
			target = Vector2(target_edge, player.get_eye_level().y)
			fly_in_loop = false
		

		if fly_in_loop:
			var old_seek_right := seek_right
			seek_right = is_left_edge_nearest()

			if seek_right == old_seek_right: return

func fly() -> void:

	match current_target:

		TARGET.EDGE_TOP:
			velocity.x = (1 if seek_right else -1) * current_speed

		TARGET.EDGE_BOTTOM:
			if global_position.distance_to(target) <= 1: on_reach_target_pos()
			fly_to(target)

		TARGET.PLAYER:
			velocity.x = (1 if player.global_position.x > global_position.x else -1) * current_speed

	is_out_of_bounds = !(global_position.x > fly_range_left_edge and global_position.x < fly_range_right_edge)

	update_seek_right()

func fly_to(target_pos: Vector2) -> void:
	velocity = global_position.direction_to(target_pos) * charge_speed

func on_reach_target_pos() -> void:
	
	
	#target = Vector2(get_furthest_edge(), global_position.y)
	current_target = TARGET.PLAYER


func update(delta):
	if !is_active: return

	super(delta)
