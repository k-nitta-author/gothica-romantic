@tool
extends FlyingEnemy

func on_turn_around(currentPosition :Vector2) -> void: if !can_see_player: return

func on_vision_area_entered(area: Area2D):
    attack()
