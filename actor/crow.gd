extends "res://actor/flying_enemy.gd"

func on_turn_around(currentPosition :Vector2) -> void:

	if !can_see_player: return

func on_vision_area_entered(area: Area2D):

	selected_state = BaseActor.STATES.MELEE