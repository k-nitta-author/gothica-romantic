class_name  Player
extends BaseActor

@onready var swordSprite : Sprite2D = $sword
@onready var gunshotEffect : Sprite2D = $gunshot
@onready var firingPoint : Marker2D = $gunshot/firingPoint

var is_ducking :bool

func set_is_flipped(value: bool):	
	super(value)

func update() -> void:
	super()

func use_input(event: InputEvent):
	pass

func shoot():
	var new_bullet: BaseBullet = preload("uid://dtcy6guqe5887").instantiate()
	new_bullet.movement_angle = 270 if is_flipped else 90
	emit_signal("fire_gun", new_bullet, firingPoint.global_position)

	
