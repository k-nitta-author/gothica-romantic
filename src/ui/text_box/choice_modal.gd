extends Control

@onready var anim := $anim

func add_choice(choice_text: String, callback_method: Callable) -> void:
    var b := Button.new()

    b.text = choice_text

    b.connect("pressed", on_choice_made)
    b.connect("pressed", callback_method)

    add_child(b)

func on_choice_made() -> void:
    queue_free()