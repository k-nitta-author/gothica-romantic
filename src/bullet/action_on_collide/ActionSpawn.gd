class_name ActionSpawnOnCollide
extends ActionOnCollide

@export var actor_scene: PackedScene

signal spawn_at(position: Vector2)

func setup(b: BaseBullet, s: Stage) -> void:

    b.connect("spawn_at", s.actorManager.spawn_actor)

func act_on(b: BaseBullet) -> void:

    b.isInactive = true

    var actor: BaseActor = actor_scene.instantiate()
    actor.global_position = b.global_position

    emit_signal("spawn_at", actor)