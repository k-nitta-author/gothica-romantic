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
func act_on(b: BaseBullet) -> void:

    # cast ray using the world2d
    var space_state = b.get_world_2d().direct_space_state
    var query = PhysicsRayQueryParameters2D.create(Vector2.ZERO, b.velocity)
    var result := space_state.intersect_ray(query)

    b.velocity = b.velocity.bounce(result.normal)

    current_bounce_number -= 1

    if current_bounce_number == 0: b.isInactive = true