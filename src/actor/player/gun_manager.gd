class_name GunManager
extends Node

@onready var player_bullet := preload("uid://dtcy6guqe5887")

# bulet related variables
@export var bulletsMax: int: set = set_bullets_max
var bulletsCurrent: int: set = set_bullets_current

var player : Player

func Setup(p: Player) -> GunManager:
	player = p

	return self

# overrides the parent's shoot method
func shoot():
	if bulletsCurrent == 0: return

	var new_bullet: BaseBullet = player_bullet.instantiate()
	new_bullet.movement_angle = 270 if player.is_flipped else 90
	player.emit_signal("fire_gun", new_bullet, player.firingPoint.global_position)
	bulletsCurrent -= 1

# sets the current number of bullets;
func set_bullets_current(value: int) -> void:

	var old_value = bulletsCurrent
	bulletsCurrent = clamp(value, 0, bulletsMax)

	if player == null: return

	player.emit_signal("on_bullets_current_change", old_value, bulletsCurrent)

# sets the maximum number of potions;
func set_bullets_max(value: int) -> void:
	var old_value = bulletsMax
	bulletsMax = value

	bulletsCurrent = bulletsMax

	if player == null: return

	player.emit_signal("on_bullets_max_change", old_value, bulletsCurrent)
