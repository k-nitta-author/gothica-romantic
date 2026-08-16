class_name BaseActor
extends CharacterBody2D

enum ACTOR_TYPE{
	PLAYER,
	ENEMY,
	SPECIAL
}

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

@export var speed : float
@export var speed_in_air_horizontal: float
@export var speed_in_air_vertical: float

@export var jump_force : float

var current_state : BaseState:
	set(value):
		current_state = value

signal has_died(actor: BaseActor)
signal has_hp_changed(actor: BaseActor, old_hp: float, new_hp: float)

var stage: Stage

func bind_to_hud(hudLayer: HudLayer):
	pass

func bind_dependencies():
	pass

func update():
	move_and_slide()