extends BreakableProp


func destroy() -> void: emit_signal("spawn_effect", EffectsManager.SPLATTER.BASE_EXPLOSION)