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

@onready var playerHpBar : ProgressBar = $Control/PlayerHpBar
@onready var enemyHpBar : ProgressBar = $Control/EnemyHpBar
@onready var dialogBox : DialogBox = $Control/DialogBox
@onready var textBox: TextBox = $Control/TextBox
@onready var anim: AnimationPlayer = $anim
@onready var autoSaveIcon: TextureRect = $Control/autoSaveIcon

func _unhandled_input(event: InputEvent) -> void:

    if event.is_action_pressed("pause"):
        if currentState != STATE.PAUSED:
            currentState = STATE.PAUSED
        else:
            currentState = STATE.RESUMED