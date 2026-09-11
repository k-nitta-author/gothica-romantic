class_name ActionBounce
extends ActionOnCollide

@export var max_bounce_number : int:
	set(value):
		max_bounce_number = value
		current_bounce_number = max_bounce_number

var current_bounce_number : int:
	set(value):
		current_bounce_number = clamp(value, 0, max_bounce_number)

# override to allow for bouncing
func act_on(b: BaseBullet, area: Area2D) -> void:
	
	# cast ray using the world2d
	var space_state = b.get_world_2d().direct_space_state
	
	# create query and set up for collision
	var query = PhysicsRayQueryParameters2D.create(b.global_position, b.global_position + b.velocity*1000)
	query.collide_with_areas = true
	query.collide_with_bodies = false
	query.collision_mask = 8
	
	# intersect the ray
	var result := space_state.intersect_ray(query)
	
	# bounce!
	b.velocity = b.velocity.bounce(result.normal)
	current_bounce_number -= 1
	
	# disappear when max bounces
	if current_bounce_number == 0:
		super(b, area)
