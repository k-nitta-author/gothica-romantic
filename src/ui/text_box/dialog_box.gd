class_name DialogBox
extends Panel

@onready var richTextLabel : RichTextLabel = $bodyLabel
@onready var headerTextLabel : Label = $headerLabel

var dialog_duration: float = 1.0

func display(name_header: String, body: String) -> void:
    visible = true

    headerTextLabel.text = name_header
    richTextLabel.text = body

    var t = get_tree().create_tween()

    t.tween_property(richTextLabel, "visible_ratio", 1.0, dialog_duration)