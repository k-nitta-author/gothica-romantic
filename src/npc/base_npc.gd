class_name BaseNPC
extends Node2D

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

func bind_dependencies(hud_layer: HudLayer) -> void:
	var dialogBox := hud_layer.dialogBox 

	connect("notify_display_dialog", dialogBox.display)

func can_talk() -> bool:
	return (dialog_array.size() > 0) and is_player_interactible

func _ready() -> void:
	interactionArea.connect("area_entered", on_area_entered)
	interactionArea.connect("area_exited", on_area_exited)

func next_dialog() -> String: return dialog_array.pop_front()

func interact() -> void:
	var d = next_dialog()
	emit_signal("notify_display_dialog", character_name, d)

func _unhandled_input(event: InputEvent) -> void:

	if !can_talk(): return

	if event.is_action_pressed("interact"):
		interact()
		toolTip.visible = can_talk()

func on_area_exited(area: Area2D) -> void:
	is_player_interactible = false
	toolTip.visible = can_talk()

func on_area_entered(area: Area2D) -> void:
	is_player_interactible = true
	toolTip.visible = can_talk()
