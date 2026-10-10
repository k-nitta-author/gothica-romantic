extends Control

enum STATES {BASIC, SAVE_GAME_MODAL, SETTINGS, HIDDEN}

var current_state := STATES.BASIC: set = set_current_state

# the start level signal
signal start_level()

# intiialize each button
@onready var startButton := $startButton
@onready var loadButton := $continueButton
@onready var settingsButton := $settingsButton
@onready var exitButton := $exitButton

# the save game modal
var save_game_modal
var save_game_modal_scene : PackedScene = preload("uid://dy0j84bmvhox2")

# the settigns modal 
var settings_modal
var settings_modal_scene : PackedScene = preload("uid://dkxidum8tt7pr")

var game : Game

func exit_old_state(value: STATES) -> void:
	match value:
		STATES.BASIC:
			pass
		STATES.SAVE_GAME_MODAL:
			pass
		STATES.SETTINGS:
			pass
		STATES.HIDDEN:
			pass

func set_current_state(value: STATES) -> void:

	var old_value = current_state
	current_state = value

	exit_old_state(old_value)
	
	match current_state:

		STATES.BASIC:
			pass
			#show()
		STATES.SAVE_GAME_MODAL:
			pass
			#show_save_game_modal()
		STATES.SETTINGS:
			pass
			#show_settings_modal()
		STATES.HIDDEN:
			pass
			#hide()

func bind_to_game(g: Game) -> void:
	game = g

	loadButton.disabled = !game.saveManager.save_files_exist()

func _ready() -> void:
	startButton.connect("pressed", start_game)
	loadButton.connect("pressed", load_game)
	settingsButton.connect("pressed", settings_menu)
	exitButton.connect("pressed", exit_game)

# show the save game modal
func show_save_game_modal() -> void:
	save_game_modal = save_game_modal_scene.instantiate()
	save_game_modal.bind_to_game(game)
	# save_game_modal.connect("return_to_previous_screen", hide)
	add_child(save_game_modal)
	save_game_modal.setup()

# remove the save game modal
func on_quit_save_game_modal() -> void:
	hide_save_game_modal()

# show the settings modal
func show_settings_modal() -> void:
	settings_modal = settings_modal_scene.instantiate()
	settings_modal.connect("return_to_previous_screen", on_quit_settings_game_modal)
	add_child(settings_modal)

# called when the settings modal is quit
func on_quit_settings_game_modal() -> void: settings_modal.queue_free()

# called when the save modal is quit
func hide_save_game_modal() -> void: save_game_modal.queue_free()

# called when the player clicks the start button
func start_game() -> void: emit_signal("start_level")

# called when the load game button
func load_game() -> void: show_save_game_modal()

# called when the settings button is clicked
func settings_menu() -> void: show_settings_modal()

# called when the exit button is clicked
func exit_game() -> void: get_tree().quit()
