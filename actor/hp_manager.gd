class_name HPManager
extends BaseManager

@export var max_hp: int:
	set(value):
		max_hp = value
		current_hp = max_hp

@onready var current_hp: int

var actor : BaseActor


func set_current_hp(value, a: BaseActor) -> void:
	var old_value = current_hp
	current_hp = clamp(value, 0, max_hp)
		
	if current_hp != old_value:
		a.emit_signal("has_hp_changed", a, old_value, current_hp)
		
	if current_hp == 0 and old_value != 0:  
		a.emit_signal("has_died", a)

		a.visible = false
		a.isInactive = true
		a.collision_layer = 64

	else:
		a.visible = true
		a.isInactive = false
