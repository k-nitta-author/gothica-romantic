class_name BaseBullet
extends Area2D

@export_range(0.0, 10.0, 0.1) var lifeTime: float

@onready var lifeTimeCurrent: float

@onready var sprite2D = $Sprite2D


signal notify_attack_connection(collision_point: Vector2, flipped: bool, type: Stage.SPLATTER)

var isInactive: bool: set = set_is_inactive

func bind_dependencies(stage: Stage):

	connect("notify_attack_connection", stage.spawn_effects)

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
		
@export var velocity : Vector2

func set_is_inactive(value: bool):
		isInactive = value

		call_deferred("set", "monitorable", !value)
		call_deferred("set", "monitoring", !value)

		visible = !value

# based on the equation used in this video:
# https://www.youtube.com/watch?v=MklBo7c3_4Q
func calculate_angle_to_reach_x(distance: float, grav: float, speed: float) -> float:

	var theta =  asin(distance * gravity / pow(speed, 2)) / 2

	return theta 

func _ready() -> void:
	connect("area_entered", on_area_entered)

func on_area_entered(area: Area2D) -> void:
	if area is BaseProp or area.owner is BaseActor:
		isInactive = true

		var collision_point := self.global_position

		emit_signal("notify_attack_connection", collision_point, self.velocity.y < 0, Stage.SPLATTER.SHOOT)

func update(delta):

	if lifeTimeCurrent >= lifeTime:
		isInactive = true
		
	lifeTimeCurrent += delta

	velocity.y += bullet_gravity

	global_position += velocity * delta 
