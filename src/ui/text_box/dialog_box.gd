class_name DialogBox
extends Panel

@onready var richTextLabel : RichTextLabel = $bodyLabel
@onready var headerTextLabel : Label = $headerLabel

@export var per_character_speed := .01

func display(name_header: String, body: String) -> void:
    visible = true

    headerTextLabel.text = name_header
    richTextLabel.text = body
    richTextLabel.visible_ratio = 0.0

    var dialog_duration: float = body.length() * per_character_speed

    var t = get_tree().create_tween()

    t.tween_property(richTextLabel, "visible_ratio", 1.0, dialog_duration)
