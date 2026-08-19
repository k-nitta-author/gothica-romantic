extends Parallax2D

@export var parallax_speed_x : float
@export var parallax_speed_y : float


func _process(delta: float) -> void:
	scroll_offset += Vector2(parallax_speed_x, parallax_speed_y)
