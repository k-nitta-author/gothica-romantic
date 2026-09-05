extends Camera2D

# the old limit values
@onready var old_limit_left: int = limit_left
@onready var old_limit_right: int = limit_right

# settings enum
enum SETTINGS {
	FOLLOW_PLAYER,
	FOCUS_ON_AREA
}

@export var current_setting: SETTINGS = SETTINGS.FOLLOW_PLAYER
@export var target_position : Vector2i

var player : Player

# bind all dependencies that the stage has access to
func bind_dependencies(s: Stage) -> void:
	player = s.player

func update() -> void:
	match current_setting:

		SETTINGS.FOCUS_ON_AREA: focus_on_area()
		SETTINGS.FOLLOW_PLAYER: follow_player()

# creates a temporary camera at a given position
func focus_on_area() -> void:

	# set up relevant members for the camera
	limit_left = target_position.x
	limit_right = target_position.x + get_window().size.x

# kill and reset the current camera to player's camera
func follow_player() -> void:

	if player == null: return

	# set up relevant members for the camera
	limit_left = old_limit_left
	limit_right = old_limit_right

	global_position = player.global_position

