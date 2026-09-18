extends Sprite2D

@onready var anim: AnimationPlayer = $anim

const DAMAGE_TIME:= 1.0
const HITFLASH_ANIM := "hitflash"

@export var is_hit_flashing: bool:
	set(value):
		is_hit_flashing = value

		if anim == null: await ready

		if is_hit_flashing:
			anim.play(HITFLASH_ANIM)
			var t = get_tree().create_timer(DAMAGE_TIME)

			t.connect("timeout", on_timer_timeout)
		
		else: anim.play("RESET")

func on_timer_timeout() -> void: is_hit_flashing = false
