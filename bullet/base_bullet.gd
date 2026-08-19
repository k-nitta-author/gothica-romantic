class_name BaseBullet
extends Area2D

@export_range(0.0, 10.0, 0.1) var lifeTime: float

@onready var lifeTimeCurrent: float

@onready var sprite2D = $Sprite2D

var isInactive: bool: set = set_is_inactive

func bind_dependencies(stage: Stage):
	pass

@export_range(0, 360, 1.0) var movement_angle : int:
	set(value):
		movement_angle = value
		velocity = Vector2.UP.rotated(deg_to_rad(movement_angle)) * speed

@export var speed : float:
	set(value):
		speed = value
		velocity = Vector2.UP.rotated(deg_to_rad(movement_angle)) * speed
		
@export var velocity : Vector2


func set_is_inactive(value: bool):
		isInactive = value

		call_deferred("set", "monitorable", !value)
		call_deferred("set", "monitoring", !value)

		visible = !value

func _ready() -> void:
	connect("area_entered", on_area_entered)

func on_area_entered(area: Area2D) -> void:
	if area is BaseProp or area.owner is BaseActor:
		isInactive = true

func update(delta):

	if lifeTimeCurrent >= lifeTime:
		isInactive = true
		
	lifeTimeCurrent += delta

	global_position += velocity * delta 
