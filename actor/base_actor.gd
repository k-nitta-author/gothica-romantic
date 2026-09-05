class_name BaseActor
extends CharacterBody2D

@onready var anim : AnimationPlayer = $anim
@onready var sprite : Sprite2D = $Sprite2D
@onready var hitbox : Area2D = $Hitbox
@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@onready var eyeLevelMarker : Marker2D = $eyeLevelMarker
@onready var stateLabel: Label = $stateLabel
@onready var soundSfxStream: AudioStreamPlayer2D = $"sound sfx stream"
@onready var attackRay: RayCast2D = $attackRay

enum ACTOR_TYPE{ PLAYER, ENEMY, SPECIAL}

enum STATES{ IDLE, MOVING, FALLLING, JUMPING, MELEE, SHOOT, DUCKING, LANDING , DAMAGED}

@export var isInactive: bool: set = set_is_inactive 
@export var actorType: ACTOR_TYPE
@export var max_hp: int:
	set(value):
		max_hp = value
		current_hp = max_hp

@onready var current_hp: int:
	set(value):
		var old_value = current_hp
		current_hp = clamp(value, 0, max_hp)

		if current_hp != old_value:
			emit_signal("has_hp_changed", self, old_value, current_hp)

		if current_hp == 0 and old_value != 0:
			emit_signal("has_died", self)

			visible = false
			isInactive = true
			collision_layer = 64

		else:
			visible = true
			isInactive = false
			
@export_category("Physics")
@export var speed : float: set = set_speed
@export var speed_in_air_horizontal: float
@export var speed_in_air_vertical: float
@export var jump_force : float
@export var knockback_impulse: float

var current_speed : float # whenever speed is changed, set this

@export_category("States")

var previous_state : STATES

@export var selected_state : STATES:
	set(value):

		var old_state = selected_state
		selected_state = value

		if (!self.is_node_ready()): await self.ready

		if old_state == selected_state: return

		match selected_state:
			STATES.IDLE:
				current_state = idle_state
			STATES.JUMPING:
				current_state = jump_state
			STATES.MOVING:
				current_state = move_state
			STATES.FALLLING:
				current_state = falling_state
			STATES.MELEE:
				current_state = melee_state
			STATES.SHOOT:
				current_state = shoot_state
			STATES.LANDING:
				current_state = landing_state
			STATES.DUCKING:
				current_state = ducking_state
			STATES.DAMAGED:
				current_state = damaged_state

@export_category("States")
@export var jump_state : JumpState
@export var idle_state : IdleState
@export var melee_state: MeleeState
@export var move_state : MoveState
@export var shoot_state: ShootState 
@export var landing_state: LandingState
@export var falling_state: FallingState
@export var ducking_state: DuckingState
@export var damaged_state: DamagedState

@export_category("Misc")
@export var is_flipped : bool: set = set_is_flipped
@export var can_flip: bool = true
@export var is_stunned : bool 


var current_state : ActorState:
	set(value):
		current_state = value

		if current_state == null: return

		current_state.set_up(self)
		current_state.enter_state()

signal has_died(actor: BaseActor)
signal has_hp_changed(actor: BaseActor, old_hp: float, new_hp: float)
signal fire_gun(bulletScene: BaseBullet, position: Vector2)

signal attacked_at_point(collision_point, flipped, splatter_type)

var stage: Stage

var is_attacking: bool
var is_shooting: bool

func set_speed(value: float) -> void:
	current_speed = speed
	speed = value

func _ready() -> void:
	hitbox.connect("area_entered", on_hitbox_entered)

func get_eye_level() -> Vector2: return eyeLevelMarker.global_position

func on_hitbox_entered(_area: Area2D):
	pass

func set_is_inactive(value: bool):
		isInactive = value

		if !is_node_ready(): await ready

		hitbox.call_deferred("set", "monitorable", !value)
		hitbox.call_deferred("set", "monitoring", !value)

		collision_shape.call_deferred("set", "disabled", isInactive)
	
		if value == false:  soundSfxStream.stop()

		visible = !value

func set_is_flipped(value: bool):

	if !can_flip: return

	var old_value = is_flipped
	is_flipped = value

	if old_value != is_flipped:
		scale.x *= -1
		stateLabel.scale.x *= -1

func knockback(area: Area2D) -> void:

	var fall_speed_multiplier := 16
	var x = (1 if area.global_position.x < global_position.x else -1) * knockback_impulse
	var y = speed_in_air_vertical * fall_speed_multiplier

	velocity = Vector2(x, y)

	can_flip = false

	selected_state = STATES.DAMAGED


func bind_to_hud(_hudLayer: HudLayer):
	pass

func walk() -> void: pass

func attack() -> void: pass

func hit_stun() -> void: pass

func notify_attack_connection() -> void:
	
	if !attackRay.is_colliding(): return
	emit_signal("attacked_at_point", attackRay.get_collision_point(), is_flipped, stage.SPLATTER.SLASH)


func stop() -> void: pass

func go() -> void: velocity.x = 0	

func bind_dependencies(s: Stage):
	connect("fire_gun", s.bulletManager.add_bullet)

func update():

	if isInactive: return 

	if current_state != null:
		current_state.update()

	var absoluteX = abs(velocity.x)

	is_flipped = (velocity.x < 0) if absoluteX > 0 else is_flipped

	move_and_slide()
