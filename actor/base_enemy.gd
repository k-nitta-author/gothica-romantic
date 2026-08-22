extends BaseActor

@export_category("Activity")
@export var seek_right : bool # if true, the enemy seeks the right
@export var can_see_player : bool
@export var is_active : bool
@export var is_awake: bool: set = set_is_awake

var player: Player

signal turn_around

var is_attacking: bool

@onready var visionArea : Area2D = $VisionArea

@export var default_state_on_awake : BaseActor.STATES

func bind_dependencies(stage: Stage):

	player = stage.get_player()

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

func on_vision_area_entered(area: Area2D):

	can_see_player = true
	is_active = true
	is_awake = true
	
func on_vision_area_exited(area: Area2D):
	pass

func walk() -> void:
	velocity = Vector2(1 if seek_right else -1,0) * speed
	anim.play("walk")

func attack() -> void:
	is_attacking = true

func update_seek_right() -> void: pass

func update():

	if !is_active: return

	super()
	is_flipped = player.global_position.x < global_position.x
