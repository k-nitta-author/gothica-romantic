class_name HudLayer
extends CanvasLayer

enum STATE {
	START_SCREEN,
	RESUMED,
	PAUSED,
	SETTINGS,
}

@export var currentState: STATE = STATE.START_SCREEN:
	set(value):
		currentState = value

		match currentState:
			STATE.RESUMED:
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
				get_start_screen().visible = true

@onready var playerHpBar : ProgressBar = $Control/BattleControl/PlayerHpBar
@onready var enemyHpBar : ProgressBar = $Control/BattleControl/EnemyHpBar
@onready var battleControl : Control = $Control/BattleControl
@onready var dialogBox : DialogBox = $Control/DialogBox
@onready var startScreen = $Control/StartScreen

@onready var bulletBar: Array[Node] = [
	$Control/BattleControl/BulletIcon,
	$Control/BattleControl/BulletIcon2,
	$Control/BattleControl/BulletIcon3,
	$Control/BattleControl/BulletIcon4,
	$Control/BattleControl/BulletIcon5,
	$Control/BattleControl/BulletIcon6]

@onready var textBox: TextBox = $Control/TextBox
@onready var anim: AnimationPlayer = $anim
@onready var autoSaveIcon: TextureRect = $Control/autoSaveIcon

@onready var pauseGamePanel = $Control/PauseGamePanel

var game

func _ready() -> void:

	pauseGamePanel.connect("return_to_previous_screen", on_game_paused)
	pauseGamePanel.connect("return_to_main_menu", on_main_menu)

func bind_game(g: Game) -> void:
	game = g

	startScreen.bind_to_game(game)

func on_main_menu() -> void: game.unload_stage()

func on_game_paused() -> void:
	pauseGamePanel.hide()
	get_tree().paused = false

func bind_to_player(p: Player):
	p.connect("has_hp_changed", update_hp_bar)
	p.connect("on_bullets_current_change", update_bullet_bar)
	p.connect("on_potions_current_change", $Control/BattleControl/potionIcons.update_potion_icons)

func bind_boss(bosses: Array): for b in bosses: battleControl.bind_boss_hp_bar(b)

func get_start_screen() -> Control: return $Control/StartScreen

func update_bullet_bar(_old_value: int, bulletsCurrent: int):

	var bulletBarIdx := bulletsCurrent - 1

	bulletBar[bulletBarIdx].visible = true

	for i in range(6):

		bulletBar[i].visible = i < bulletsCurrent

func update_hp_bar(_actor: BaseActor, _old_value: int, current_hp: int):
	playerHpBar.value = current_hp


func _unhandled_input(event: InputEvent) -> void:

	if currentState == STATE.START_SCREEN: return

	if event.is_action_pressed("pause"):
		if currentState == STATE.RESUMED:
			currentState = STATE.PAUSED
		else:
			currentState = STATE.RESUMED
