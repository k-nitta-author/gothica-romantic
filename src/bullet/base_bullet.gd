class_name BaseBullet
extends Area2D

@export var current_mode : ActionOnCollide

@export_range(0.0, 10.0, 0.1) var lifeTime: float

@onready var lifeTimeCurrent: float
@onready var sprite2D = $Sprite2D

signal notify_attack_connection(collision_point: Vector2, flipped: bool, type: Stage.SPLATTER)

@export var isInactive: bool: set = set_is_inactive

@export_range(0, 360, 1.0) var movement_angle : int:
	set(value):
		movement_angle = value
		velocity = Vector2.UP.rotated(deg_to_rad(movement_angle)) * speed

@export var speed : float:
	set(value):
		speed = value
		velocity = Vector2.UP.rotated(deg_to_rad(movement_angle)) * speed

@export var bullet_gravity: float:
	set(value):
		bullet_gravity = value
		
var velocity : Vector2

func bind_dependencies(stage: Stage):
	current_mode.setup(self, stage)

	connect("notify_attack_connection", stage.effectsManager.spawn_effects)

func set_is_inactive(value: bool):
		isInactive = value

		call_deferred("set", "monitorable", !value)
		call_deferred("set", "monitoring", !value)

		visible = !value

# based on the equation used in this video:
# https://www.youtube.com/watch?v=MklBo7c3_4Q
func calculate_angle_to_reach_x(distance: float, grav: float, spd: float) -> float:

	var theta =  asin(distance * grav / pow(spd, 2)) / 2

	return theta 

func _ready() -> void: connect("area_entered", on_area_entered)

func on_area_entered(area: Area2D) -> void: if area is BaseProp or area.owner is BaseActor: current_mode.act_on(self)

# called by the bullet manager each tick
func update(delta):

	# check if the lifetime has been surpassed
	if lifeTimeCurrent >= lifeTime:
		isInactive = true
	
	# add time
	lifeTimeCurrent += delta

	# add gravity
	velocity.y += bullet_gravity

	# move bullet
	global_position += velocity * delta 
