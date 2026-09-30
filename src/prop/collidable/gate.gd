extends PropCollidable

@export var is_open := false: set = set_is_open

func set_is_open(value: bool) -> void:
	is_open = value

	if !is_node_ready(): await ready

	if is_open:
		$anim.play("open")
	else:
		$anim.play("open", -1.0, true)

func on_triggered() -> void:
	is_open = !is_open
