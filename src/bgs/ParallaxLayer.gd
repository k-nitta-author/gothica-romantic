class_name BaseLayer
extends Parallax2D

@export var parallax_speed_x : float
@export var parallax_speed_y : float


@export var stopped: bool

func _process(_delta: float) -> void:

	if stopped == true:

		scroll_offset += Vector2(parallax_speed_x, parallax_speed_y) / 2
