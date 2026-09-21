class_name ActionOnCollide
extends Resource


# sets up the bullet to perform the collision
func setup(b: BaseBullet, s: Stage) -> void:
	b.connect("notify_attack_connection", s.effectsManager.spawn_effects)

func act(b: BaseBullet, collision_point: Vector2) -> void:
	b.emit_signal("notify_attack_connection", collision_point, b.velocity.y < 0, EffectsManager.SPLATTER.SHOOT)
	b.isInactive = true

# meant to be overriden by child classes
func act_on(b: BaseBullet, area: Area2D) -> void: act(b, b.global_position)

# meant to be overridden by child classes
func act_on_body(b: BaseBullet, body: Node2D) -> void: act(b, b.global_position)
