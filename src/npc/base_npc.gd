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
var has_spoken_with: bool

var current_dialog_idx := 0

signal notify_display_dialog(name: String, body: String)

# set up interaction area
func _ready() -> void:
	interactionArea.connect("area_entered", on_area_entered)
	interactionArea.connect("area_exited", on_area_exited)

# setter for the current state
func set_current_state(value: STATES):

	currentState = value

	animate_state(currentState)

# pick the anim name and play it
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

# when level is loaded; each npc must check their data and update according to their result
# overwrite as needed in child class
func setup_persistent_status(data: Dictionary) -> void:

	var interactible : bool = data.get("interactible")
	var spoken_with : bool = data.get("spoken_with")

	visible = interactible
	has_spoken_with = spoken_with

# binds all dependencies (in this case the hud)
func bind_dependencies(hud_layer: HudLayer) -> void:

	if hud_layer == null: return

	connect("notify_display_dialog", hud_layer.display_dialog)

# returns whether the npc can talk
func can_talk() -> bool:
	return (dialog_array.size() > 0) and is_player_interactible and visible

# resets dialog to allow player to review a character's dialog
func reset_dialog() -> void: pass

# get the next dialog item
func next_dialog() -> String:
	return dialog_array.pop_front() if dialog_array.size() > 0 else ""

# called when player presses interact
func interact() -> void:
	var d = next_dialog()
	emit_signal("notify_display_dialog", character_name, d)

func _unhandled_input(event: InputEvent) -> void:

	# do nothing if the npc can talk
	if !can_talk(): return

	# check if the player pressed interact
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
func on_triggered() -> void: pass
