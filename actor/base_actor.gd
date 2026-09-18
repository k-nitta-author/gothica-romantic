class_name BaseActor
extends CharacterBody2D

# collision mask constants for all actors to switch to as needed
const COLLIDE_WITH_ONLY_NON_PLATFORMS = 128
const COLLIDE_WITH_TILEMAP_MASK := 1152
const COLLIDE_WITH_ENEMY_MASK := 112

# all the child nodes for the base actor
@onready var anim : AnimationPlayer = $anim
@onready var sprite : Sprite2D = $Sprite2D
@onready var hitbox : Area2D = $Hitbox
@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@onready var eyeLevelMarker : Marker2D = $eyeLevelMarker
@onready var stateLabel: Label = $stateLabel
@onready var soundSfxStream: AudioStreamPlayer2D = $"sound sfx stream"
@onready var attackRay: RayCast2D = $attackRay
@onready var state_manager = $stateManager

# the different types of actors in this game
enum ACTOR_TYPE{ PLAYER, ENEMY, SPECIAL}

# all the possible states
enum STATES{ IDLE, MOVING, JUMPING, FALLLING, MELEE, SHOOT, DUCKING, LANDING , DAMAGED}

@export var immune_to_stun: bool # if true, the enemy is unable to be stunned when damaged

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

		previous_state = selected_state
		selected_state = value

		if (!self.is_node_ready()): await self.ready

		if previous_state == selected_state: return

		current_state = state_manager.match_state(selected_state, self)

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
		var old_state = current_state
		current_state = value

		if current_state == old_state: return

		if value == null:
			current_state = old_state
			return

		if old_state != null: old_state.exit_state()

		current_state.set_up(self)
		current_state.enter_state()

# all relevant signals
signal has_died(actor: BaseActor) # send when actor died
signal has_hp_changed(actor: BaseActor, old_hp: float, new_hp: float) # when hp is changed
signal fire_gun(bulletScene: BaseBullet, position: Vector2) # when the actor fires the gun
signal attacked_at_point(collision_point, flipped, splatter_type) # called to notify where an attack took place

var stage: Stage

# variables to make sure actor is unable to switch while doing these
var is_attacking: bool
var is_shooting: bool

# perform the basic idling actions
# meant to be extended by child classes
# reset attacking and shooting behaviors
func idle() -> void:
	is_attacking = false
	is_shooting = false

func revert_to_previous_state() -> void:
	var old_state = selected_state
	selected_state = previous_state
	previous_state = old_state

func set_speed(value: float) -> void:
	current_speed = speed
	speed = value

func _ready() -> void:
	hitbox.connect("area_entered", on_hitbox_entered)

# get the eye level for a given actor
func get_eye_level() -> Vector2: return eyeLevelMarker.global_position

# called whenever the hitbox is entered
func on_hitbox_entered(_area: Area2D) -> void: pass

# do a falling motion
# extend as needed
func fall(fall_height: float) -> void: pass

# setter for the isInactive variable
func set_is_inactive(value: bool) -> void:
		isInactive = value

		if !is_node_ready(): await ready

		hitbox.set_is_inactive(isInactive)
	
		if !value:  soundSfxStream.stop()

		visible = !value

# settter for the is_flipped variable
func set_is_flipped(value: bool):

	if !can_flip: return

	var old_value = is_flipped
	is_flipped = value

	if old_value != is_flipped:
		scale.x *= -1
		stateLabel.scale.x *= -1

# perform a knockback and throw the actor in a given direction
func knockback(area: Area2D) -> void: pass

# bind the actor to the hud if it affects the hud
func bind_to_hud(_hudLayer: HudLayer) -> void: pass

# call when the actor tries to walk
func walk() -> void: pass

# call when the actor tries to attack
func attack() -> void: pass

# end the attack and reset any variables
func cease_attack() -> void: pass

# perform a hit stun
func hit_stun() -> void: pass

# try to perform a jump
func jump() -> void: pass

# try to stop moving
func stop() -> void:
	current_speed = 0
	velocity.x = 0

# try to move by restoring the speed of the actor
func go() -> void:	
	current_speed = speed

# notify the stage that a given attack has collided
func notify_attack_connection() -> void:
	
	if !attackRay.is_colliding() or attackRay.get_collider().owner.isInactive: return

	emit_signal("attacked_at_point", attackRay.get_collision_point(), is_flipped, stage.SPLATTER.SLASH)

# bind all dependencies and connect relevant signals
func bind_dependencies(s: Stage):

	stage = s

	connect("fire_gun", s.bulletManager.add_bullet)
	connect("has_died", s.propManager.spawn_collectible)
	connect("attacked_at_point", s.effectsManager.spawn_effects)

# update method; called each tick for active actors
func update():

	if current_state != null:
		current_state.update()

	var absoluteX = abs(velocity.x)

	is_flipped = (velocity.x < 0) if absoluteX > 0 else is_flipped

	move_and_slide()
