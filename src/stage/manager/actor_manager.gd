extends Node2D

@onready var children := get_children()
@onready var player := $Player
@onready var bosses : Array

var can_update := false
var stage

# get the current boss
func get_boss() -> Array: return get_bosses()

# get the current player
func get_player() -> Player: return player

# called when the actor's hp reaches 0
func on_actor_died(_actor: BaseActor) -> void:
	pass

# spawn actor
func spawn_actor(actorScene: BaseActor) -> void:

	actorScene.bind_dependencies(stage)
	actorScene.connect("has_died", on_actor_died)

	call_deferred("add_child", actorScene)

# called by actor manager to add references to stage and members
func bind_dependencies(_stage: Stage) -> void:

	stage = _stage
	for c in get_children():
		c.bind_dependencies(stage)
		c.connect("has_died", on_actor_died)
		if c is BaseEnemy and c.is_boss: bosses.append(c)

# returns the array of bosses
func get_bosses() -> Array: return bosses

# update all actors each tick
func _physics_process(_delta: float) -> void:
	
	# if this is set to not update
	if !can_update: return

	# update
	for c: BaseActor in get_children():
		if c.isInactive: continue

		c.update()

# controls the player's use of input
func _unhandled_input(event: InputEvent) -> void:
	player.use_input(event)
