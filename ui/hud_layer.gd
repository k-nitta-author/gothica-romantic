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
				pass
			STATE.PAUSED:
				pass
			STATE.SETTINGS:
				pass

@onready var playerHpBar : ProgressBar = $Control/BattleControl/PlayerHpBar
@onready var enemyHpBar : ProgressBar = $Control/BattleControl/EnemyHpBar
@onready var battleControl : Control = $Control/BattleControl
@onready var dialogBox : DialogBox = $Control/DialogBox

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


func bind_to_player(p: Player):
	p.connect("has_hp_changed", update_hp_bar)
	p.connect("on_bullets_current_change", update_bullet_bar)


func bind_boss(bosses: Array):

	for b in bosses: battleControl.bind_boss_hp_bar(b)
	

func update_bullet_bar(old_value: int, bulletsCurrent: int):

	var bulletBarIdx := bulletsCurrent - 1

	bulletBar[bulletBarIdx].visible = true

	for i in range(6):

		bulletBar[i].visible = i < bulletsCurrent

func update_hp_bar(_actor: BaseActor, _old_value: int, current_hp: int):
	playerHpBar.value = current_hp


func _unhandled_input(event: InputEvent) -> void:

	if event.is_action_pressed("pause"):
		if currentState != STATE.PAUSED:
			currentState = STATE.PAUSED
		else:
			currentState = STATE.RESUMED
