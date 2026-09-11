class_name HudLayer
extends CanvasLayer

enum STATE {
	START_SCREEN,
	RESUMED,
	PAUSED,
	SETTINGS,
	TRANSITION
}

@export var currentState: STATE = STATE.START_SCREEN:
	set(value):
		currentState = value

		match currentState:
			STATE.RESUMED:
				startScreen.visible = false
				battleControl.visible = true
				pauseGamePanel.visible = false
				get_tree().paused = false
			STATE.PAUSED:
				pauseGamePanel.visible = true
				get_tree().paused = true
			STATE.SETTINGS:
				pass
			STATE.START_SCREEN:
				battleControl.visible = false
				startScreen.visible = true
			STATE.TRANSITION:
				pass

@onready var dialogBox : DialogBox = $Control/DialogBox
@onready var startScreen = $Control/StartScreen

@onready var textBox: TextBox = $Control/TextBox
@onready var anim: AnimationPlayer = $anim
@onready var autoSaveIcon: TextureRect = $Control/autoSaveIcon

@onready var pauseGamePanel = $Control/PauseGamePanel

@onready var battleControl : Control = $Control/BattleControl

var effectLayer: EffectsLayer

var game

func _ready() -> void:
	pauseGamePanel.connect("return_to_previous_screen", on_game_paused)
	pauseGamePanel.connect("return_to_main_menu", on_main_menu)

func bind_game(g: Game) -> void:
	game = g

	startScreen.bind_to_game(game)
	effectLayer = game.effectLayer

func on_main_menu() -> void:

	currentState = STATE.TRANSITION

	effectLayer.play_transition(EffectsLayer.TRANS.WIPE_UP)

	await effectLayer.transition_finished

	currentState = STATE.RESUMED

	game.unload_stage()

	effectLayer.play_transition(EffectsLayer.TRANS.WIPE_UP, true)

func on_game_paused() -> void:
	pauseGamePanel.hide()
	get_tree().paused = false
	currentState = STATE.RESUMED

func bind_to_player(p: Player):
	battleControl.bind_to_player(p)

func bind_boss(bosses: Array): for b in bosses: battleControl.bind_boss_hp_bar(b)

func get_start_screen() -> Control: return $Control/StartScreen

func _unhandled_input(event: InputEvent) -> void:

	if currentState == STATE.START_SCREEN or currentState == STATE.TRANSITION: return

	if event.is_action_pressed("pause"):
		if currentState == STATE.RESUMED:
			currentState = STATE.PAUSED
		else:
			currentState = STATE.RESUMED
