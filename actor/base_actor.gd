class_name BaseActor
extends CharacterBody2D

@onready var anim : AnimationPlayer = $anim
@onready var sprite : Sprite2D = $Sprite2D
@onready var hitbox : Area2D = $Hitbox
@onready var collision_shape: CollisionShape2D = $CollisionShape2D

enum ACTOR_TYPE{ PLAYER, ENEMY, SPECIAL}

enum STATES{ IDLE, MOVING, FALLLING, JUMPING, MELEE, SHOOT, DUCKING, LANDING }

@export var isInactive: bool: set = set_is_inactive 
@export var actorType: ACTOR_TYPE
@export var max_hp: int:
	set(value):
		max_hp = value
		current_hp = max_hp

@onready var current_hp: int:
	set(value):
		var old_value = current_hp
		current_hp = value

		emit_signal("has_hp_changed", self, old_value, current_hp)



		if current_hp == 0:
			emit_signal("has_died", self)

			visible = false

		else: visible = true
			

@export var speed : float
@export var speed_in_air_horizontal: float
@export var speed_in_air_vertical: float
@export var jump_force : float

@export_category("States")

@export var selected_state : STATES:
	set(value):
		selected_state = value

		if (!self.is_node_ready()): await self.ready

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

@export var jump_state : JumpState
@export var idle_state : IdleState
@export var melee_state: MeleeState
@export var move_state : MoveState
@export var shoot_state: ShootState 
@export var landing_state: LandingState
@export var falling_state: FallingState
@export var ducking_state: DuckingState

var is_flipped : bool: set = set_is_flipped

var current_state : ActorState:
	set(value):
		current_state = value

		if current_state == null: return

		current_state.set_up(self)
		current_state.enter_state()

signal has_died(actor: BaseActor)
signal has_hp_changed(actor: BaseActor, old_hp: float, new_hp: float)
signal fire_gun(bulletScene: BaseBullet, position: Vector2)

var stage: Stage


func set_is_inactive(value: bool):
		isInactive = value

		call_deferred("set", "monitorable", !value)
		call_deferred("set", "monitoring", !value)

		visible = !value

		if isInactive: emit_signal("destroyed", self)

func set_is_flipped(value: bool):
	var old_value = is_flipped
	is_flipped = value

	if old_value != is_flipped:
		scale.x *= -1

func bind_to_hud(hudLayer: HudLayer):
	pass

func bind_dependencies(stage: Stage):
	connect("fire_gun", stage.bulletManager.add_bullet)

func _unhandled_input(event: InputEvent) -> void:
	if current_state != null:
		current_state.handle_input(event)

func update():

	if current_state != null:
		current_state.update()

	var absoluteX = abs(velocity.x)

	is_flipped = (velocity.x < 0) if absoluteX > 0 else is_flipped

	move_and_slide()
