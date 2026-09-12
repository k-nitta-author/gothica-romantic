extends PlatformerEnemy

@export var max_number_of_minions : int
@onready var current_number_of_minions: int

@export var max_number_of_shots : int
@onready var current_number_of_shots: int

# override can shoot method
func can_shoot() -> bool:
	return !(
		shoot_state == null or\
	 	is_shooting or\
		is_attacking or\
		current_number_of_shots < max_number_of_shots)

# extend update to allow enemy to turn around
func update():
	if hitbox.get_overlapping_bodies() and is_attacking: seek_right = !seek_right
	super()

# extend melee attack to res
func attack() -> void:
	super()
	current_number_of_shots = 0


# override fire method 
func fire() -> BaseBullet:

	var bullet: BaseBullet

	if (current_number_of_shots < max_number_of_shots) or (current_number_of_minions < max_number_of_minions): 
		bullet = super()

		bullet.movement_angle = 340 if is_flipped else 20

		# assume that bullet is bone bullet 
		bullet.current_mode.connect("spawn_at", on_spawn_actor)
	
		current_number_of_shots += 1

	return bullet

# called when an actor spawns
func on_spawn_actor(actor: BaseActor)-> void:
	current_number_of_minions += 1
	actor.connect("has_died", on_spawned_actor_died)

func on_spawned_actor_died(_actor: BaseActor) -> void:
	current_number_of_minions -= 1

# override the original method to ensure necromancer cannot turn around
func update_seek_right() -> void: if !is_attacking: super()
