extends PlatformerEnemy

@export var max_number_of_minions : int
@onready var current_number_of_minions: int

# override fire method 
func fire() -> BaseBullet:

	var bullet: BaseBullet

	if current_number_of_minions < max_number_of_minions: 
		bullet = super()

		bullet.movement_angle = 340 if is_flipped else 20

		# assume that bullet is bone bullet 
		bullet.current_mode.connect("spawn_at", on_spawn_actor)
	
	return bullet

# called when an actor spawns
func on_spawn_actor(actor: BaseActor)-> void:
	current_number_of_minions += 1
	actor.connect("has_died", on_spawned_actor_died)

func on_spawned_actor_died(_actor: BaseActor) -> void:
	current_number_of_minions -= 1
