extends Control

signal start_level(from_beginning)

@onready var startButton := $startButton
@onready var loadButton := $continueButton
@onready var settingsButton := $settingsButton
@onready var exitButton := $exitButton

func _ready() -> void:

	startButton.connect("pressed", start_game)
	loadButton.connect("pressed", load_game)
	settingsButton.connect("pressed", settings_menu)
	exitButton.connect("pressed", exit_game)

func start_game() -> void: emit_signal("start_level", false)

func load_game() -> void: emit_signal("start_level", true)

func settings_menu() -> void: pass

func exit_game() -> void: get_tree().quit()
