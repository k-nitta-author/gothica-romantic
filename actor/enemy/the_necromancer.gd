@tool
extends PlatformerEnemy

@export var max_number_of_minions : int
@onready var current_number_of_minions: int

@export var max_number_of_shots : int
@onready var current_number_of_shots: int

# override can shoot method
func can_shoot() -> bool:
	return !(shoot_state == null or\
	 		is_shooting or\
			is_attacking or\
			current_number_of_shots >= max_number_of_shots)

func update(delta):
	super(delta)

	if is_on_wall(): seek_right = !seek_right

func attack() -> void:
	currentMovementMode = MOVEMENT_MODE.ATTACKING
	update_seek_right()

	super()

func cease_attack() -> void:
	is_attacking = false
	currentMovementMode = MOVEMENT_MODE.CHASE_PLAYER

# override fire method 
func fire() -> BaseBullet:

	var bullet: BaseBullet

	const left_ward_angle = 340
	const rightward_angle = 20

	if current_number_of_shots < max_number_of_shots: 
		bullet = super()

		bullet.movement_angle = left_ward_angle if is_flipped else rightward_angle

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
