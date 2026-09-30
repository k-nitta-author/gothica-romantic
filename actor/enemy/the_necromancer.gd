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

func stop_if_reach_slope(delta) -> void:
	if !selected_state == STATES.MELEE:
		super(delta)
	
func turn_to_face_player(player_on_same_level: bool) -> void:
	if selected_state == STATES.MELEE:
		super(player_on_same_level)

# extend update to allow enemy to turn around
func update(delta):
	super(delta)

	if test_move(self.transform, direction * delta) == true and is_attacking:
		seek_right = !seek_right

# extend melee attack to res
func attack() -> void:
	super()

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
