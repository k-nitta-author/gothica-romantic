class_name BaseBullet
extends Area2D

@onready var sprite2D = $Sprite2D

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

func update(delta):
    global_position += velocity * delta 