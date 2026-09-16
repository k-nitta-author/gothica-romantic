class_name GunManager
extends Node

# bulet related variables
@export var bulletsMax: int: set = set_bullets_max
var bulletsCurrent: int: set = set_bullets_current

var firingPoint : Marker2D
var is_flipped: bool

# overrides the parent's shoot method
func shoot():
	if bulletsCurrent == 0: return

	var new_bullet: BaseBullet = preload("uid://dtcy6guqe5887").instantiate()
	new_bullet.movement_angle = 270 if is_flipped else 90
	emit_signal("fire_gun", new_bullet, firingPoint.global_position)
	bulletsCurrent -= 1

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