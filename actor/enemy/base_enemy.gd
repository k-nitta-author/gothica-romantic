@tool
class_name BaseEnemy
extends BaseActor

const COLLIDE_WITH_ENEMY_AND_TILEMAP := 136

@export var is_boss : bool

@export_category("Activity")
@export var seek_right : bool # if true, the enemy seeks the right
@export var can_see_player : bool
@export var is_active : bool # if active, it can move and be interacted with
@export var is_awake: bool: set = set_is_awake # if it's awake, it can move and in relation to the player

@export_category("combat")
@export var shoot_bullet : PackedScene
@export_range(0.0, 1000, 1.0) var max_melee_range : float = 100: set = set_max_melee_range
@export_range(0.0, 1000, 1.0) var max_shoot_range : float = 100: set = set_max_shoot_range

@export var melee_limit : float = 100

var player: Player

@onready var onGroundRayLeft : RayCast2D = $onGroundRayLeft
@onready var onGroundRayRight : RayCast2D = $onGroundRayRight

@onready var firingPoint : Marker2D = $firingPoint
@onready var visionArea : Area2D = $VisionArea

@export var default_state_on_awake : BaseActor.STATES

signal turn_around

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
	super(s)
	player = s.get_player()

func set_is_inactive(value: bool): super(value)

func set_is_awake(value: bool):
	var old_value = is_awake
	is_awake = value

	if !self.is_node_ready(): await ready

	if is_awake and is_awake != old_value: 
		if anim.has_animation("awaken"): anim.play("awaken")

		else: selected_state = default_state_on_awake

func set_is_flipped(value: bool):

	if !can_flip: return

	var old_value = is_flipped
	is_flipped = value

	if old_value != is_flipped:
		scale.x *= -1
		stateLabel.scale.x *= -1

func _ready() -> void:
	super()

	# configure on ground ray
	onGroundRayLeft.top_level = true
	onGroundRayRight.top_level = true

	hitbox.connect("body_entered", on_hitbox_body_entered)

	visionArea.connect("area_entered", on_vision_area_entered)
	visionArea.connect("area_exited", on_vision_area_exited)

func on_hitbox_body_entered(body: Node2D) -> void: bump(body)

func on_hitbox_entered(area: Area2D):

	if Engine.is_editor_hint(): return

	# check if the area belongs to a boss type enemy
	if area.owner is BaseEnemy:
		if area.owner.is_boss and area.owner.is_attacking:
			current_hp -= max_hp		
	else:
		current_hp -= 1

		# wake up the enemy if they aren't already
		can_see_player = true
		is_active = true
		is_awake = true
		selected_state = default_state_on_awake

	selected_state = STATES.DAMAGED

func on_vision_area_entered(_area: Area2D):
	can_see_player = true
	is_active = true
	is_awake = true
	
func on_vision_area_exited(_area: Area2D): pass

func idle() -> void:
	super()
	
	collision_mask = BaseEnemy.COLLIDE_WITH_ENEMY_AND_TILEMAP
	
	shoot()
	attack()


# called when actor bumps into body
func bump(body: Node2D) -> void: pass

func walk() -> void:
	shoot()
	attack()
	
func should_turn() -> bool: return false

func update_seek_right() -> void: pass

func has_player_in_melee_range() -> bool:
	var distance = global_position.distance_to(player.global_position) 
	return max_shoot_range > max_melee_range and max_melee_range  > distance

func has_player_in_shoot_range() -> bool:
	var distance = self.global_position.distance_to(player.global_position) 
	return max_melee_range < distance and distance < max_shoot_range

func attack() -> void:
	var can_attack = !(melee_state == null or is_shooting or is_attacking)

	if can_attack and has_player_in_melee_range():
		super()
		is_attacking = true
		selected_state = BaseActor.STATES.MELEE

func cease_shoot() -> void:
	is_shooting = false
	is_attacking = false

func shoot():
	var can_shoot = !(shoot_state == null or is_shooting or is_attacking)

	if can_shoot and has_player_in_shoot_range():
		is_shooting = true
		selected_state = BaseActor.STATES.SHOOT

func fire() -> BaseBullet:
	var new_bullet: BaseBullet = shoot_bullet.instantiate()
	new_bullet.movement_angle = 270 if is_flipped else 90
	new_bullet.bind_dependencies(stage)

	emit_signal("fire_gun", new_bullet, firingPoint.global_position)

	return new_bullet

func update_on_ground_rays() -> void:
	onGroundRayLeft.global_position.x = global_position.x - collision_shape.shape.size.x
	onGroundRayLeft.global_position.y = global_position.y

	onGroundRayRight.global_position.x = global_position.x + collision_shape.shape.size.x
	onGroundRayRight.global_position.y = global_position.y

func update(delta):
	update_on_ground_rays()

	if !is_active or Engine.is_editor_hint(): return
	velocity = Vector2((1 if seek_right else -1) * current_speed, 0)
	super(delta)
