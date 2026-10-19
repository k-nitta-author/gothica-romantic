class_name BaseNPC
extends Node2D

enum STATES {IDLE, TALKING, MOVING}

@export var currentState : STATES: set = set_current_state

@export var character_name : String
@export_multiline var dialog_body : String

@onready var interactionArea: Area2D = $interactArea
@onready var bodySprite: Sprite2D = $body
@onready var anim: AnimationPlayer = $anim
@onready var toolTip: Node2D = $toolTip

var is_player_interactible: bool
var is_talking_with : bool
var has_spoken_with: bool

var current_dialog_idx := 0

signal notify_start_dialog(dialog_array: Array[Dictionary])
signal notify_conceal_dialog()

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

	connect("notify_start_dialog", hud_layer.display_dialog)
	connect("notify_conceal_dialog", hud_layer.conceal_dialog)

func on_hud_state_changed(current_hud_state: HudLayer.STATE) -> void:
	is_talking_with = false

# returns whether the npc can talk
func can_talk() -> bool:
	return is_player_interactible and visible and !is_talking_with

# resets dialog to allow player to review a character's dialog
func reset_dialog() -> void: pass

func get_dialog_array(raw_dialog: String) -> Array[Dictionary]:

	var dialog_array : Array = raw_dialog.split("\n")

	var a : Array[Dictionary]

	for d in dialog_array:
		
		var new_dialog_entry := {"header_name": character_name, "body": d}

		a.append(new_dialog_entry)

	return a

# called when player presses interact
func interact() -> void:
	var dialog_array = get_dialog_array(dialog_body)
	emit_signal("notify_start_dialog", dialog_array)
	is_talking_with = true

func _unhandled_input(event: InputEvent) -> void:

	# do nothing if the npc can talk
	if !can_talk(): return

	# check if the player pressed interact
	if event.is_action_pressed("interact"):
		interact()
		toolTip.visible = can_talk()
		get_viewport().set_input_as_handled()

func on_area_entered(_area: Area2D) -> void:
	is_player_interactible = true
	toolTip.visible = can_talk()

func on_area_exited(_area: Area2D) -> void:
	is_player_interactible = false
	toolTip.visible = can_talk()
	is_talking_with = false

	emit_signal("notify_conceal_dialog")

# method to be triggered in the event of trigger area activation
func on_triggered() -> void: pass
