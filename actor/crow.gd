@tool
extends FlyingEnemy

func on_turn_around(_currentPosition :Vector2) -> void:
    if !can_see_player: return