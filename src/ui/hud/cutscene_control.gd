class_name CutsceneControl
extends Control

@onready var choice_modal_scene := preload("uid://diiq0av1wxh6u")
@onready var dialogBox := $DialogBox

var choice_modal

func setup(hud_layer: HudLayer) -> void:
    pass

func display_dialog(dialog_array: Array[Dictionary]) -> void:
    dialogBox.display(dialog_array)


func conceal_dialog() -> void:
    dialogBox.conceal()

func display_choice_modal(choices :Array[String]) -> void:
    choice_modal = choice_modal_scene.instantiate()
    
    choice_modal.setup(self)
    choice_modal.add_choices(choices)
    
    add_child(choice_modal)

func clear_choice_modal() -> void:
    choice_modal.queue_free()



