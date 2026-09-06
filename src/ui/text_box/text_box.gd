class_name TextBox
extends Panel

@onready var richTextLabel = $richTextLabel

@export_range(0.0, 0.1, 0.01) var per_character_speed: float

# set the text and display the text
func display_text(body: String) -> void:

    var tween := create_tween()

    richTextLabel.text = body

    var total_text_time := per_character_speed * body.length()

    tween.tween_property(richTextLabel, "visible_ratio", 1.0, total_text_time)
