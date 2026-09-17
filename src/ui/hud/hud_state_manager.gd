extends Node

enum STATE {
	START_SCREEN,
	RESUMED,
	PAUSED,
	SETTINGS,
	DIED,
	TRANSITION
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
			STATE.START_SCREEN:
				pass
			STATE.TRANSITION:
				pass
			STATE.DIED:
				pass