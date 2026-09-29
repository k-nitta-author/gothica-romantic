extends Sprite2D

@onready var collision_shape := $Area2D/CollisionShape2D

func start() -> void:
	self.set_deferred("monitorable", true)
	collision_shape.set_deferred("disabled", false)

# overrides the base method
func end() -> void:
	self.set_deferred("monitorable", false)
	collision_shape.set_deferred("disabled", true)