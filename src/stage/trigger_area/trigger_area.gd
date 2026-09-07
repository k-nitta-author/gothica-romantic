extends Area2D

signal triggered

@export var triggered_entities: Array[NodePath]

func _ready() -> void:

	for nPath in triggered_entities:
		var n = get_node(nPath)

		if !(n is BaseActor or n is BaseProp or n is ActorSpawner): continue

		connect("triggered", n.on_triggered)

	self.connect("area_entered", on_area_entered)
	self.connect("area_exited", on_area_exited)

func on_area_entered(area: Area2D) -> void:
	emit_signal("triggered")

func on_area_exited(area: Area2D) -> void:
	emit_signal("triggered")