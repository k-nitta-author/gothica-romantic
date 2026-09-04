extends Area2D


func _ready() -> void:
	connect("area_entered", on_area_entered)

func on_area_entered(area: Area2D) -> void:
	if area.owner is BaseActor:

		var actor: BaseActor = area.owner

		actor.isInactive = true

		