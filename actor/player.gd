class_name  Player
extends BaseActor

@export var isRejectingInput: bool

@onready var swordSprite : Sprite2D = $sword
@onready var gunshotEffect : Sprite2D = $gunshot
@onready var firingPoint : Marker2D = $gunshot/firingPoint

@onready var eyeLevelMarker : Marker2D = $eyeLevelMarker

@export var bulletsMax: int: set = set_bullets_max
var bulletsCurrent: int: set = set_bullets_current

signal on_bullets_current_change(old_value: int, new_value: int)
signal on_bullets_max_change(old_value: int, new_value: int)

var is_ducking :bool

func get_eye_level() -> Vector2: return eyeLevelMarker.global_position

func set_bullets_current(value: int) -> void:

	var old_value = bulletsCurrent
	bulletsCurrent = clamp(value, 0, bulletsMax)
	emit_signal("on_bullets_current_change", old_value, bulletsCurrent)

func set_bullets_max(value: int) -> void:
	var old_value = bulletsMax
	bulletsMax = value

	bulletsCurrent = bulletsMax
	emit_signal("on_bullets_max_change", old_value, bulletsCurrent)

func _unhandled_input(event: InputEvent) -> void:
	if current_state != null:
		current_state.handle_input()

func set_is_flipped(value: bool):	
	super(value)

func update() -> void:
	super()

	if current_state != null:
		current_state.handle_input()

func use_input(event: InputEvent):
	pass

func on_hitbox_entered(area: Area2D):
	
	current_hp -= 1

	knockback(area)
	
	selected_state = STATES.DAMAGED

func heal(amount: int):
	current_hp += amount

func walk() -> void:
	velocity.x = Input.get_axis("move_left", "move_right") * speed
	anim.play("walk")

func shoot():
	if bulletsCurrent == 0: return

	var new_bullet: BaseBullet = preload("uid://dtcy6guqe5887").instantiate()
	new_bullet.movement_angle = 270 if is_flipped else 90
	emit_signal("fire_gun", new_bullet, firingPoint.global_position)
	bulletsCurrent -= 1
	
