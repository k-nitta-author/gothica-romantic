class_name ActionSpawnOnCollide
extends ActionOnCollide

@export var actor_scene: PackedScene

signal spawn_at(actor: BaseActor)

# override existing setup
func setup(b: BaseBullet, s: Stage) -> void:

	if !self.is_connected("spawn_at", s.actorManager.spawn_actor):
		connect("spawn_at", s.actorManager.spawn_actor)


func act_on_body(b: BaseBullet, body: Node2D) -> void:
	var actor: BaseActor = actor_scene.instantiate()
	actor.global_position = b.global_position
	emit_signal("spawn_at", actor)
	
	super(b, body)