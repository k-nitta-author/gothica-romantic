class_name ActorSpawner
extends Marker2D

enum MODE {SPAWN_AT_POINT, SPAWN_RELATIVE_TO_CAMERA}

@export var currentMode : MODE = MODE.SPAWN_AT_POINT

@export var spawn_offset : Vector2

@export var ActorToSpawn: PackedScene

signal request_spawn(actorScene: PackedScene, pos: Vector2, relative_to_camera: bool)

func _ready() -> void:
	var p = get_parent()

	if !p is Stage:
		p.connect("request_spawn", p.spawn_actor)

func spawn():
	var a : BaseActor = ActorToSpawn.instantiate() 
	var pos : Vector2
	var relative_to_camera: bool = currentMode == MODE.SPAWN_RELATIVE_TO_CAMERA

	match currentMode:
		MODE.SPAWN_AT_POINT:
			pos = global_position
		MODE.SPAWN_RELATIVE_TO_CAMERA:
			relative_to_camera = true
			pos = spawn_offset

	emit_signal("request_spawn", a, pos, relative_to_camera)

func on_triggered(): spawn()