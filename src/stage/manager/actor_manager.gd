extends BaseManager

@onready var children := get_children()
@onready var player := $Player
@onready var bosses : Array

var camera

var can_update := false

# get the current boss
func get_boss() -> Array: return get_bosses()

# get the current player
func get_player() -> Player: return player

# called when the actor's hp reaches 0
func on_actor_died(_actor: BaseActor, _dropped_item: CollectibleProp = null) -> void:
	pass

# spawn actor
func spawn_actor(actorScene: BaseActor, custom_position: Vector2, relative_to_camera := false) -> void:
	
	# handle the cases where the entity is meant to spawn relative to the camera
	if relative_to_camera:
		actorScene.global_position = custom_position + camera.global_position
	else:
		actorScene.global_position = custom_position

	actorScene.bind_dependencies(stage)
	actorScene.connect("has_died", on_actor_died)

	call_deferred("add_child", actorScene)

# called by actor manager to add references to stage and members
func bind_dependencies(_stage: Stage) -> void:
	super(_stage)

	camera = _stage.stageCamera

	for c in get_children():
		c.bind_dependencies(stage)
		c.connect("has_died", on_actor_died)
		if c is BaseEnemy and c.is_boss: bosses.append(c)

# returns the array of bosses
func get_bosses() -> Array: return bosses

# update all actors each tick
func _physics_process(delta: float) -> void:
	
	# if this is set to not update
	if !can_update: return

	# update
	for c: BaseActor in get_children():
		if is_instance_valid(c):

			c.update(delta)

# controls the player's use of input
func _unhandled_input(event: InputEvent) -> void:
	player.use_input(event)
