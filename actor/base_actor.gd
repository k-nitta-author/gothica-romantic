class_name BaseActor
extends CharacterBody2D

enum ACTOR_TYPE{
	PLAYER,
	ENEMY,
	SPECIAL
}

@export var speed : float 
@export var speed_in_air_horizontal: float
@export var speed_in_air_vertical: float

@export var jump_force : float

func update():
	pass
