class_name BaseBullet
extends Area2D

@onready var sprite2D = $Sprite2D

@export var movement_angle : int:
    set(value):
        movement_angle = value
        velocity = Vector2.UP.rotated(movement_angle) * speed

@export var speed : Vector2:
    set(value):
        speed = value
        velocity = Vector2.UP.rotated(movement_angle) * speed
        
@export var velocity : Vector2

func Update(delta):
    global_position += velocity * delta 