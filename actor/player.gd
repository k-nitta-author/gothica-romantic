class_name  Player
extends BaseActor

@export var isRejectingInput: bool

# potion related methods
# max_potion_count
@export var max_potion_count : int:
	set(value):
		max_potion_count = value
		current_potion_count = max_potion_count

# current_potion_count; clamped to current max value
@onready var current_potion_count : int: set = set_current_potion_count

const POTION_HEAL_AMOUNT := 3

# important child variables
@onready var swordSprite : Sprite2D = $sword
@onready var gunshotEffect : Sprite2D = $gunshot
@onready var firingPoint : Marker2D = $gunshot/firingPoint

# bulet related variables
@export var bulletsMax: int: set = set_bullets_max
var bulletsCurrent: int: set = set_bullets_current

# bullet related signals
signal on_bullets_current_change(old_value: int, new_value: int)
signal on_bullets_max_change(old_value: int, new_value: int)

signal on_potions_current_change(old_value: int, new_value: int)

var is_ducking :bool

# sets the current number of potions; clamps value to between 0 and max_potion_count
func set_current_potion_count(value: int) -> void:

	var old_value = current_potion_count
	current_potion_count = clamp(value, 0, max_potion_count)

	if current_potion_count != old_value: emit_signal("on_potions_current_change", old_value, current_potion_count)

# sets the current number of bullets;
func set_bullets_current(value: int) -> void:

	var old_value = bulletsCurrent
	bulletsCurrent = clamp(value, 0, bulletsMax)
	emit_signal("on_bullets_current_change", old_value, bulletsCurrent)

# sets the maximum number of potions;
func set_bullets_max(value: int) -> void:
	var old_value = bulletsMax
	bulletsMax = value

	bulletsCurrent = bulletsMax
	emit_signal("on_bullets_max_change", old_value, bulletsCurrent)

func _unhandled_input(_event: InputEvent) -> void:
	if current_state != null:
		current_state.handle_input()

	if _event.is_action_pressed("drinkPotion"):
		current_potion_count -= 1
		heal(POTION_HEAL_AMOUNT)

# sets the current flip state;
func set_is_flipped(value: bool): super(value)

func update() -> void:
	super()

	if current_state != null:
		current_state.handle_input()

func use_input(_event: InputEvent):
	pass

func on_hitbox_entered(area: Area2D):
	current_hp -= 1
	knockback(area)
	selected_state = STATES.DAMAGED

# the heal method; simple
func heal(amount: int): current_hp += amount

# overrides the parent's walk method
func walk() -> void:
	velocity.x = Input.get_axis("move_left", "move_right") * speed
	anim.play("walk")

# overrides the parent's shoot method
func shoot():
	if bulletsCurrent == 0: return

	var new_bullet: BaseBullet = preload("uid://dtcy6guqe5887").instantiate()
	new_bullet.movement_angle = 270 if is_flipped else 90
	emit_signal("fire_gun", new_bullet, firingPoint.global_position)
	bulletsCurrent -= 1
	
