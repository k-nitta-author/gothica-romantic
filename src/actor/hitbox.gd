extends Area2D

@onready var collision_shape = $CollisionShape2D

func set_is_inactive(value: bool) -> void:
    call_deferred("set", "monitorable", !value)
    call_deferred("set", "monitoring", !value)
    
    collision_shape.call_deferred("set", "disabled", value)
    
    visible = !value