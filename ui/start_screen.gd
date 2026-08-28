extends Control

signal start_level(from_beginning)

@onready var startButton := $startButton
@onready var loadButton := $continueButton
@onready var settingsButton := $settingsButton
@onready var exitButton := $exitButton

var save_game_modal
var save_game_modal_scene : PackedScene = preload("uid://dy0j84bmvhox2")

func _ready() -> void:
	startButton.connect("pressed", start_game)
	loadButton.connect("pressed", load_game)
	settingsButton.connect("pressed", settings_menu)
	exitButton.connect("pressed", exit_game)

func show_save_game_modal() -> void:
	save_game_modal = save_game_modal_scene.instantiate()
	save_game_modal.connect("return_to_previous_screen", on_quit_save_game_modal)
	add_child(save_game_modal)

func on_quit_save_game_modal() -> void:
	hide_save_game_modal()

func hide_save_game_modal() -> void: save_game_modal.queue_free()

func start_game() -> void: emit_signal("start_level", false)

func load_game() -> void: emit_signal("start_level", true)

func settings_menu() -> void: pass

func exit_game() -> void: get_tree().quit()
