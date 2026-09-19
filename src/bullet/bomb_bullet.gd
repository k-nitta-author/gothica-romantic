class_name BombBullet
extends BaseBullet

@onready var anim: AnimationPlayer = $anim
@onready var explosionArea: Area2D = $explosionArea

func _ready() -> void:
    super()
    anim.connect("animation_finished", on_animation_finished)

# when the animation is finished, the bomb must disappear
func on_animation_finished(anim_name: String) -> void: if anim_name == "explode": isInactive = true

# override and connect explode signal to stage
func bind_dependencies(stage: Stage) -> BaseBullet:
    connect("explode", stage.effectsManager.spawn_effects)
    return self

# the explode method
func explode() -> void:
    velocity = Vector2.ZERO
    anim.play("explode")

# override and play an explosion which is able to damage player
func on_body_entered(body: Node2D) -> void: explode()

# override and play an explosion which is able to damage player
func on_area_entered(area: Area2D) -> void: explode()