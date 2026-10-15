class_name ActionExplode
extends ActionOnCollide

@export var explosion_duration : float

signal explode(position: Vector2, is_flipped: int, effect_type: EffectsManager.SPLATTER)

# sets up the bullet to perform the collision
func setup(b: BaseBullet, s: Stage) -> void:
    super(b, s)
    b.connect("explode", s.effectsManager.spawn_effects)

func _explode(b: BaseBullet) -> void: emit_signal("explode", b.global_position, 0, EffectsManager.SPLATTER.BASE_EXPLOSION)

# override virtual to allow for explosion
func act_on(b: BaseBullet, area: Area2D) -> void: _explode(b)

# meant to be overridden by child classes
func act_on_body(b: BaseBullet, _body: Node2D) -> void: _explode(b)