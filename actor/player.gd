extends BaseActor

@onready var swordSprite : Sprite2D = $sword
@onready var gunshotEffect : Sprite2D = $gunshot

var is_ducking :bool

func set_is_flipped(value: bool):	
	super(value)

func update() -> void:
	super()

func use_input(event: InputEvent):
	pass

	
