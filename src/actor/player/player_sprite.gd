extends Sprite2D

# if 
@export var is_flashing_transparent: bool:
	set(value):
		is_flashing_transparent = value

		if anim == null: return

		if is_flashing_transparent: anim.play("flash")

		else: anim.play("RESET")

@onready var anim : AnimationPlayer = $anim


