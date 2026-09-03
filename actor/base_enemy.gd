class_name BaseEnemy
extends BaseActor

@export var is_boss : bool

@export_category("Activity")
@export var seek_right : bool # if true, the enemy seeks the right
@export var can_see_player : bool
@export var is_active : bool # if active, it can move and be interacted with
@export var is_awake: bool: set = set_is_awake # if it's awake, it can move and in relation to the player
@export var is_stunned : bool 

@export_category("combat")
@export_range(0.0, 1000, 1.0) var max_melee_range : float = 100: set = set_max_melee_range
@export_range(0.0, 1000, 1.0) var max_shoot_range : float = 100: set = set_max_shoot_range

@export var melee_limit : float = 100

var player: Player

signal turn_around

@onready var visionArea : Area2D = $VisionArea

@export var default_state_on_awake : BaseActor.STATES

func set_max_melee_range(value: float):
	max_melee_range = value
	queue_redraw()

func set_max_shoot_range(value: float):
	max_shoot_range = value
	queue_redraw()

func hit_stun() -> void: anim.play("hitStun")

func _draw() -> void:

	if Engine.is_editor_hint():
		draw_line(Vector2(max_shoot_range, -100), Vector2(max_shoot_range, 0), Color.GREEN)
		draw_line(Vector2(-max_shoot_range, -100), Vector2(-max_shoot_range, 0), Color.GREEN)

		draw_line(Vector2(max_melee_range, -100), Vector2(max_melee_range, 0), Color.RED)
		draw_line(Vector2(-max_melee_range, -100), Vector2(-max_melee_range, 0), Color.RED)

func bind_dependencies(s: Stage):

	player = s.get_player()

func set_is_inactive(value: bool):
	super(value)

func set_is_awake(value: bool):
	var old_value = is_awake
	is_awake = value

	if !self.is_node_ready(): await ready

	if is_awake and is_awake != old_value: 
		if anim.has_animation("rise"): anim.play("rise")

		else: selected_state = default_state_on_awake

func _ready() -> void:
	super()

	visionArea.connect("area_entered", on_vision_area_entered)
	visionArea.connect("area_exited", on_vision_area_exited)

func on_hitbox_entered(area: Area2D):
	
	if area is BaseBullet or area.owner is Player:
		current_hp -= 1
		selected_state = STATES.DAMAGED

func on_vision_area_entered(_area: Area2D):
	can_see_player = true
	is_active = true
	is_awake = true
	
func on_vision_area_exited(_area: Area2D):
	pass

func walk() -> void:
	velocity = Vector2(1 if seek_right else -1,0) * speed

	shoot_if_possible()
	attack_if_possible()

	if is_attacking or is_shooting: return

	anim.play("walk")

func attack() -> void:
	super()
	is_attacking = true

	selected_state = BaseActor.STATES.MELEE

func update_seek_right() -> void: pass

func has_player_in_melee_range() -> bool: return self.global_position.distance_to(player.global_position) < max_melee_range

func has_player_in_shoot_range() -> bool: return self.global_position.distance_to(player.global_position) < max_shoot_range

func attack_if_possible() -> void:

	if has_player_in_melee_range():
		attack()

	else: selected_state = BaseActor.STATES.IDLE

func shoot_if_possible() -> void:

	if has_player_in_shoot_range():
		shoot()

	else: selected_state = BaseActor.STATES.IDLE

func shoot():
	is_shooting = true

func update():

	if !is_active: return

	super()
	is_flipped = player.global_position.x < global_position.x
