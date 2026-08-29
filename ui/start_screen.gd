extends Control

# the start level signal
signal start_level(from_beginning)

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

func _ready() -> void:
	startButton.connect("pressed", start_game)
	loadButton.connect("pressed", load_game)
	settingsButton.connect("pressed", settings_menu)
	exitButton.connect("pressed", exit_game)

# show the save game modal
func show_save_game_modal() -> void:
	save_game_modal = save_game_modal_scene.instantiate()
	save_game_modal.connect("return_to_previous_screen", on_quit_save_game_modal)
	add_child(save_game_modal)

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
func start_game() -> void: emit_signal("start_level", false)

# called when the load game button
func load_game() -> void: emit_signal("start_level", true)

# called when the settings button is clicked
func settings_menu() -> void: show_settings_modal()

# called when the exit button is clicked
func exit_game() -> void: get_tree().quit()
