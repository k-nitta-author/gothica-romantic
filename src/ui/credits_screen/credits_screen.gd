extends Control

@onready var anim := $anim
@onready var skipLabel := $skipLabel

var is_skipping: bool

signal return_to_previous_screen

func _ready() -> void:
	anim.play("credits")

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
		is_skipping = true

	if event.is_action_released("pause"):
		is_skipping = false