class_name  Player
extends BaseActor

@export var isRejectingInput: bool

@onready var swordSprite : Sprite2D = $sword
@onready var gunshotEffect : Sprite2D = $gunshot
@onready var firingPoint : Marker2D = $gunshot/firingPoint

@export var bulletsMax: int: set = set_bullets_max
var bulletsCurrent: int: set = set_bullets_current

signal on_bullets_current_change(old_value: int, new_value: int)
signal on_bullets_max_change(old_value: int, new_value: int)

var is_ducking :bool

func set_bullets_current(value: int) -> void:

	var old_value = bulletsCurrent
	bulletsCurrent = value
	emit_signal("on_bullets_current_change", old_value, bulletsCurrent)

func set_bullets_max(value: int) -> void:
	var old_value = bulletsMax
	bulletsMax = value

	bulletsCurrent = bulletsMax
	emit_signal("on_bullets_max_change", old_value, bulletsCurrent)


func set_is_flipped(value: bool):	
	super(value)

func update() -> void:
	super()

func use_input(event: InputEvent):
	pass

func on_hitbox_entered(area: Area2D):
	
	knockback(area)
	
	selected_state = STATES.DAMAGED

func knockback(area: Area2D) -> void:
	var x = (1 if area.global_position.x < global_position.x else -1) * knockback_impulse
	var y = speed_in_air_vertical * 16

	velocity = Vector2(x, y)

	can_flip = false

func heal(amount: int):
	current_hp += amount

func shoot():
	if bulletsCurrent == 0: return

	var new_bullet: BaseBullet = preload("uid://dtcy6guqe5887").instantiate()
	new_bullet.movement_angle = 270 if is_flipped else 90
	emit_signal("fire_gun", new_bullet, firingPoint.global_position)
	bulletsCurrent -= 1
	
