class_name BombBullet
extends BaseBullet

@onready var anim: AnimationPlayer = $anim
@onready var explosionArea: Area2D = $explosionArea

# override and connect explode signal to stage
func bind_dependencies(stage: Stage):
    connect("explode", stage.effectsManager.spawn_effects)

# override and play an explosion which is able to damage player
func on_area_entered(area: Area2D) -> void:
    if area.owner is BaseActor:
        isInactive = true
        velocity = Vector2.ZERO
        anim.play("explode")