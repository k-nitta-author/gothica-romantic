class_name ActorSpawner
extends Marker2D

@export var ActorToSpawn: PackedScene

signal request_spawn(actorScene: PackedScene)

func _ready() -> void:
	var p = get_parent()

	if !p is Stage:
		p.connect("request_spawn", p.spawn_actor)

func spawn(): emit_signal("request_spawn", ActorToSpawn)

func on_triggered(): spawn()