extends Area2D

enum TRIGGER_MODE {ON_ENTER, ON_EXIT, ON_BOTH}

@export var currentTriggerMode := TRIGGER_MODE.ON_ENTER

signal triggered

@export var disabled := false
@export var number_of_triggers := 1
@export var triggered_entities: Array[NodePath]

func _ready() -> void:

	for nPath in triggered_entities:
		var n = get_node(nPath)

		if !(n is BaseActor or n is BaseProp or n is ActorSpawner or n is PropCollidable): continue

		connect("triggered", n.on_triggered)

	self.connect("area_entered", on_area_entered)
	self.connect("area_exited", on_area_exited)

func update_trigger_number() -> void:

	if number_of_triggers == -1: return

	number_of_triggers -= 1

	disabled = (number_of_triggers <= 0)

func trigger() -> void:
	update_trigger_number()

	if disabled or number_of_triggers == -1: emit_signal("triggered")

func on_area_entered(area: Area2D) -> void:

	if currentTriggerMode ==  TRIGGER_MODE.ON_BOTH or currentTriggerMode ==  TRIGGER_MODE.ON_ENTER: 
		trigger()

func on_area_exited(area: Area2D) -> void:

	if currentTriggerMode ==  TRIGGER_MODE.ON_BOTH or currentTriggerMode ==  TRIGGER_MODE.ON_EXIT: 
		trigger()