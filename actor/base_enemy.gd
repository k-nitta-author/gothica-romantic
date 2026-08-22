extends BaseActor

@export_category("Activity")
@export var seek_right : bool # if true, the enemy seeks whatever is on the right
@export var can_see_player : bool
@export var is_active : bool
@export var is_awake: bool: set = set_is_awake

var player: Player

@onready var visionArea : Area2D = $VisionArea

func bind_dependencies(stage: Stage):

	player = stage.get_player()

func set_is_inactive(value: bool):
	super(value)

func set_is_awake(value: bool):
	is_awake = value

	if !self.is_node_ready(): await ready

	if is_awake: 
		if anim.has_animation("rise"): anim.play("rise")

		else: selected_state = STATES.MOVING

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

func update():

	if !is_active: return

	super()

	# TODO: optimize this when you can. it doesn't need to be called each frame
	if player.is_on_floor():
		is_flipped = player.global_position.x < global_position.x
		seek_right = !(player.global_position.x < global_position.x)
