class_name PotionManager
extends Node

# potion related methods
# max_potion_count
@export var max_potion_count : int:
	set(value):
		max_potion_count = value
		current_potion_count = max_potion_count

# current_potion_count; clamped to current max value
@onready var current_potion_count : int = max_potion_count: set = set_current_potion_count

const POTION_HEAL_AMOUNT := 3

# potion related signal
signal on_potions_current_change(old_value: int, new_value: int)

# sets the current number of potions; clamps value to between 0 and max_potion_count
func set_current_potion_count(value: int) -> void:

	var old_value = current_potion_count
	current_potion_count = clamp(value, 0, max_potion_count)

	if current_potion_count != old_value:
		emit_signal("on_potions_current_change", old_value, current_potion_count)
