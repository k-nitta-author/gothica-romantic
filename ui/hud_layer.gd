class_name HudLayer
extends CanvasLayer

enum STATE {
    RESUMED,
    PAUSED,
    SETTINGS,
}

@export var currentState: STATE:
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
