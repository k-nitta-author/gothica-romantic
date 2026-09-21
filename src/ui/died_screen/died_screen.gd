extends Control

@onready var resumeButton : Button = $resumeButton
@onready var mainMenuButton : Button = $mainMenuButton
@onready var deathMusic: AudioStreamPlayer = $deathMusic

var game: Game
var hud_layer: HudLayer
var player : Player

signal return_to_previous_screen

func _ready() -> void:
	resumeButton.connect("pressed", on_resume_pressed)
	mainMenuButton.connect("pressed", on_main_menu_pressed)

func bind_to_player(p: Player) -> void:
	player = p
	player.connect("has_died", show_screen)

func show_screen(p: Player) -> void:
	hud_layer.currentState = HudLayer.STATE.DIED

# return to the main menu; the player has given up
func on_main_menu_pressed() -> void: emit_signal("return_to_previous_screen")

# return state to resumed when possible
# reset the level when possible
func on_resume_pressed() -> void:
	hud_layer.currentState = hud_layer.STATE.RESUMED
	game.reset_stage()

# bind to game
func bind_to_game(g: Game) -> void: game = g

# setup any references from parent
func setup(h: HudLayer) -> void:
	hud_layer = h
	game = hud_layer.game