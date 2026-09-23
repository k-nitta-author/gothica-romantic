extends StageExit

@export var is_player_interactible: bool

@onready var toolTip : Node2D = $toolTip

func _ready() -> void:
    super()
    connect("body_exited", on_body_exited)

func on_body_exited(_body: Node2D) -> void:
    is_player_interactible = false
    toolTip.visible = false

# in the case of the base_stage exit, immediately change stage
func on_body_entered(_body: Node2D) -> void:
    is_player_interactible = true
    toolTip.visible = true

func _unhandled_input(event: InputEvent) -> void:

    if !is_player_interactible: return

    if event.is_action_pressed("enterBuilding"): notify_stage_change()

# the stage change method
func notify_stage_change() -> void: emit_signal("player_exited", NextLevel)