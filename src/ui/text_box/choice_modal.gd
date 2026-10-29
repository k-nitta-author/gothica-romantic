extends Control

@onready var anim := $anim
@onready var vbox_container : VBoxContainer = $vbox_container

func setup(ccontrol :CutsceneControl) -> void:
    pass

func add_choices(choices :Array[String]):
    for c in choices: add_choice(c)

func add_choice(choice_text: String) -> Button:
    var b := Button.new()

    b.text = choice_text

    b.connect("pressed", on_choice_made)
    # b.connect("pressed", callback_method)

    vbox_container.add_child(b)

    return b

func on_choice_made() -> void:
    queue_free()