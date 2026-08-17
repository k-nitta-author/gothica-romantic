extends BaseActor

@onready var swordSprite : Sprite2D = $sword
@onready var gunshotEffect : Sprite2D = $gunshot

var is_ducking :bool

func set_is_flipped(value: bool):	
	super(value)

func update() -> void:
	super()

	velocity.x = Input.get_axis("move_left", "move_right") * speed

	if is_on_floor() and abs(velocity.x) > 0:
		anim.play("walk")

	elif !is_on_floor():
		anim.queue("falling")
		velocity.y += 2

func use_input(event: InputEvent):
	if event.is_action_pressed("jump"):
		velocity.y -= jump_force
		anim.play("jump")

	if event.is_action_pressed("duck"):
		is_ducking = true

		anim.play("duck")

	if event.is_action_released("duck"):
		is_ducking = false
		anim.play("walk")

	if event.is_action_pressed("attack"):
		anim.play("attack")

		if is_ducking:
			anim.play("duck attack")

	if event.is_action_pressed("shoot"):
		anim.play("shoot")

		if is_ducking:
			anim.play("duck shoot")

	
