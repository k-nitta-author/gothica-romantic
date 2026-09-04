@tool
extends BaseEnemy

@export var fly_in_loop: bool
@export var fly_range: float

@onready var perch_position : Vector2 = self.global_position
@onready var fly_range_left_edge: float = perch_position.x - fly_range / 2
@onready var fly_range_right_edge: float = perch_position.x + fly_range / 2

var is_out_of_bounds: bool

func _ready() -> void:

	super()

	connect("turn_around", on_turn_around)

func on_turn_around(currentPosition :Vector2) -> void: pass

func fly() -> void:
	anim.play("fly")

	velocity.x = (1 if seek_right else -1) * speed

	if !fly_in_loop: return

	is_out_of_bounds = !(global_position.x > fly_range_left_edge and global_position.x < fly_range_right_edge)

	update_seek_right()

func attack() -> void:
	super()

	velocity = global_position.direction_to(player.get_eye_level()) * speed

func update():
	if !is_active: return

	super()
	
func update_seek_right() -> void:

	if !is_out_of_bounds: return

	var distance_to_left : float = abs(fly_range_left_edge - global_position.x)
	var distance_to_right : float = abs(fly_range_right_edge - global_position.x)
	
	var old_seek_right := seek_right
	seek_right = distance_to_right > distance_to_left

	if seek_right == old_seek_right: return

	emit_signal("turn_around", global_position)
