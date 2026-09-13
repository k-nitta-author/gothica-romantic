class_name ActionSpawnOnCollide
extends ActionOnCollide

@export var actor_scene: PackedScene

signal spawn_at(actor: BaseActor)

# override existing setup
func setup(b: BaseBullet, s: Stage) -> void:

	if !self.is_connected("spawn_at", s.actorManager.spawn_actor):
		connect("spawn_at", s.actorManager.spawn_actor)


func act_on_body(b: BaseBullet, body: Node2D) -> void:

	# cast ray using the world2d
	var space_state = b.get_world_2d().direct_space_state
	
	# create query and set up for collision
	var query = PhysicsRayQueryParameters2D.create(b.global_position, b.global_position + Vector2.DOWN * 100)
	query.collide_with_areas = false
	query.collide_with_bodies = true
	query.collision_mask = 64
	
	# intersect the ray
	var result := space_state.intersect_ray(query)

	# spawn the actor
	var actor: BaseActor = actor_scene.instantiate()
	actor.global_position = result.position
	
	emit_signal("spawn_at", actor)
	
	super(b, body)