class_name BaseNPC
extends Node2D

enum STATES {IDLE, TALKING, MOVING}
@export var currentState : STATES: set = set_current_state

@export var character_name : String
@export_multiline var dialog_body : String
@onready var dialog_array : Array = dialog_body.split("\n")

@onready var interactionArea: Area2D = $interactArea
@onready var bodySprite: Sprite2D = $body
@onready var anim: AnimationPlayer = $anim
@onready var toolTip: Node2D = $toolTip

var is_player_interactible: bool

var current_dialog_idx := 0

signal notify_display_dialog(name: String, body: String)

func set_current_state(value: STATES):

	currentState = value

	animate_state(currentState)

func animate_state(state: STATES):

	if self.is_node_ready(): await ready

	var anim_name: String

	match state:
		STATES.IDLE:
			anim_name = "idle"
		STATES.TALKING:
			anim_name = "talk"
		STATES.MOVING:
			anim_name = "move"

	anim.play(anim_name)

func bind_dependencies(hud_layer: HudLayer) -> void:

	if hud_layer == null: return

	connect("notify_display_dialog", hud_layer.display_dialog)

func can_talk() -> bool:
	return (dialog_array.size() > 0) and is_player_interactible

func _ready() -> void:
	interactionArea.connect("area_entered", on_area_entered)
	interactionArea.connect("area_exited", on_area_exited)

func next_dialog() -> String:
	return dialog_array.pop_front() if dialog_array.size() > 0 else ""

func interact() -> void:
	var d = next_dialog()
	emit_signal("notify_display_dialog", character_name, d)

func _unhandled_input(event: InputEvent) -> void:

	if !can_talk(): return

	if event.is_action_pressed("interact"):
		interact()
		toolTip.visible = can_talk()

func on_area_exited(_area: Area2D) -> void:
	is_player_interactible = false
	toolTip.visible = can_talk()

func on_area_entered(_area: Area2D) -> void:
	is_player_interactible = true
	toolTip.visible = can_talk()

# method to be triggered in the event of trigger area activation
func on_triggered() -> void:
	pass