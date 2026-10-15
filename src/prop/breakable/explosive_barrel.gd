extends BreakableProp

signal spawn_effect(pos: Vector2, is_flipped: int, splatter_type: EffectsManager.SPLATTER)

func bind_dependencies(_stage: Stage) -> void:
    super(_stage)
    connect("spawn_effect", _stage.effectsManager.spawn_effects)

func destroy() -> void:
    emit_signal("spawn_effect", global_position, 0, EffectsManager.SPLATTER.BASE_EXPLOSION)