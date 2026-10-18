class_name DialogBox
extends Panel

@onready var richTextLabel : RichTextLabel = $bodyLabel
@onready var headerTextLabel : Label = $headerLabel
@onready var anim: AnimationPlayer = $anim
@onready var typingAudio: AudioStreamPlayer = $typingAudio

@onready var t: WeakRef

@export var per_character_speed := .01 # speed at which each typed character appears

var dialog_raw_text : String
var dialog_array : Array[Dictionary]

var is_typing := false # set to true when the dialog is still in progress

# called when the dialog is loaded into the dialogbox
func setup_dialog_body(raw_text: String) -> void:
	dialog_raw_text = raw_text 

# skips dialog to the end while still typing
func skip() -> void:
	is_typing = false
	richTextLabel.visible_ratio = 1.0
	t.get_ref().stop()

# the available inputs of the dialog box
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		if is_typing:
			skip()
		else:
			if dialog_array.is_empty():
				conceal()
				return

			var next := next_dialog(dialog_array)
			progress_to_next_dialog(next["header_name"], next["body"])

	if event.is_action_pressed("pause"):
		cleanup()
		conceal()

# reset dialog box
func cleanup() -> void:
	headerTextLabel.text = ""
	richTextLabel.text = ""
	richTextLabel.visible_ratio = 0.0

# hides the text box and resets it
func conceal() -> void:
	cleanup()
	hide()

# display the dialog box
func display(_dialog_array: Array[Dictionary]) -> void:
	show()
	
	dialog_array = _dialog_array
	var next := next_dialog(dialog_array)
	progress_to_next_dialog(next["header_name"], next["body"])

func progress_to_next_dialog(name_header: String, body: String) -> void:

	headerTextLabel.text = name_header
	richTextLabel.text = body
	richTextLabel.visible_ratio = 0.0

	var dialog_duration: float = body.length() * per_character_speed

	t = weakref(get_tree().create_tween()) # the tween used to animate the dialog typing

	t.get_ref().tween_property(richTextLabel, "visible_ratio", 1.0, dialog_duration)
	t.get_ref().connect("finished", on_tween_finished)

	is_typing = true

# when the tween is finished
func on_tween_finished() -> void:
	is_typing = false

# get the next dialog item
func next_dialog(_dialog_array: Array[Dictionary]) -> Dictionary:
	return _dialog_array.pop_front() if _dialog_array.size() > 0 else {}
