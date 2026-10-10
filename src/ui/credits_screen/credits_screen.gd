extends Control

signal return_to_previous_screen

func skip() -> void:
	pass

func scroll_credits() -> void:
	pass

func _process(delta: float) -> void:
	scroll_credits()

func quit() -> void:
	emit_signal("return_to_previous_screen")

func _unhandled_input(event: InputEvent) -> void:
	
	if event.is_action_pressed("pause"):
		quit()